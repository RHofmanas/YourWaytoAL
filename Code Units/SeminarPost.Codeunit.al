
#pragma warning disable LC0015
codeunit 50020 "Seminar-Post"
#pragma warning restore LC0015

{
    TableNo = "Seminar Registration Header";

    var
        CommentLine: Record "Comment Line";
        CommentLine2: Record "Comment Line";
        Customer: Record Customer;
        Instructor: Record Instructor;
        JobJournalLine: Record "Job Journal Line";
        JobtaskLine: Record "Job Task";
        PostedSeminarCharge: Record "Posted Seminar Charge";
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        PostedSeminarRegLine: Record "Posted Seminar Reg. Line";
        Resource: Record Resource;
        SeminarCharge: Record "Seminar Charge";
        SeminarJournalLine: Record "Seminar Journal Line";
        SeminarRegistrationHeader: Record "Seminar Registration Header";
        SeminarRegistrationLine: Record "Seminar Registration Line";
        SeminarRoom: Record "Seminar Room";
        SeminarSetup: Record "Seminar Setup";
        SourceCodeSetup: Record "Source Code Setup";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SeminarJnlPostLine: Codeunit "Seminar Jnl.-Post Line";
        SourceCode: Code[10];
        DialogWindow: Dialog;
        JobLedgEntryNo: Integer;
        LineCount: Integer;
        //SeminarLedgerEntryNo: Integer;
#pragma warning disable AA0470
        LineCounterLbl: Label 'Line No. #2#####';

        PostingLbl: Label 'Posting... \';
        SeminarRegLineEmptyLbl: Label 'There are no records in the table %1 associated with this %2';
        SemRegLbl: Label 'Seminar Reg. #1#####\';
#pragma warning restore AA0470

    #region 
    trigger OnRun()
    var
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
        OptionType: Enum "Option Type";
    begin
        ClearAll();
        SeminarRegistrationHeader := Rec;

        SeminarRegistrationHeader.TestField("Posting Date");
        SeminarRegistrationHeader.TestField("Document Date");
        SeminarRegistrationHeader.TestField("Starting Date");
        SeminarRegistrationHeader.TestField("Seminar No.");
        SeminarRegistrationHeader.TestField(Duration);
        SeminarRegistrationHeader.TestField("Instructor Code");
        SeminarRegistrationHeader.TestField("Seminar Room Code");
        SeminarRegistrationHeader.TestField("Job No.");
        SeminarRegistrationHeader.TestField(SeminarRegistrationHeader.Status, "Seminar Reg. Status"::Closed); //
        Instructor.Get(SeminarRegistrationHeader."Instructor Code");
        Instructor.TestField("Resource No.");
        SeminarRoom.Get(SeminarRegistrationHeader."Seminar Room Code");
        SeminarRoom.TestField("Resource No.");
        SeminarRegistrationLine.Reset();
        SeminarRegistrationLine.SetRange("Seminar Registration No.", SeminarRegistrationHeader."No.");
        if SeminarRegistrationLine.IsEmpty then
            Error(SeminarRegLineEmptyLbl, SeminarRegistrationLine.TableCaption, SeminarRegistrationHeader.TableCaption);
        DialogWindow.Open(PostingLbl + SemRegLbl + LineCounterLbl);
        DialogWindow.Update(1, SeminarRegistrationHeader."No.");
        if SeminarRegistrationHeader."Posting No." = '' then begin
            if SeminarRegistrationHeader."Posting No. Series" = '' then begin
                SeminarSetup.Get();
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                SeminarRegistrationHeader."Posting No. Series" := SeminarSetup."Posted Seminar Reg. Nos.";
            end;
            SeminarRegistrationHeader."Posting No." := NoSeriesManagement.GetNextNo(SeminarRegistrationHeader."Posting No. Series", SeminarRegistrationHeader."Posting Date", true);
            SeminarRegistrationHeader.Modify();
            Commit(); // Ends the current write transaction
        end;
        SeminarRegistrationLine.LockTable();
        SeminarLedgerEntry.LockTable();
        //SeminarLedgerEntryNo := SeminarLedgerEntry.GetLastEntryNo();
        SourceCodeSetup.Get();
        SourceCode := SourceCodeSetup.Seminar;
        PostedSeminarRegHeader.Init();
        PostedSeminarRegHeader.TransferFields(SeminarRegistrationHeader);
        PostedSeminarRegHeader."No." := SeminarRegistrationHeader."Posting No.";
        PostedSeminarRegHeader."Registration No. Series" := SeminarRegistrationHeader."No. Series";
        PostedSeminarRegHeader."Registration No." := SeminarRegistrationHeader."No.";
        PostedSeminarRegHeader."Source Code" := SourceCode;
        PostedSeminarRegHeader."User ID" := CopyStr(UserId(), 1, MaxStrLen(PostedSeminarRegHeader."User ID"));
        PostedSeminarRegHeader.Insert();
        CopyCommentLines(CommentLine."Table Name"::"Seminar Registration Header".AsInteger(),
        CommentLine."Table Name"::"Posted Seminar Registration".AsInteger(), SeminarRegistrationHeader."No.", PostedSeminarRegHeader."No.");
        CopyCharges(SeminarRegistrationHeader."No.", PostedSeminarRegHeader."No.");
        SeminarRegistrationLine.SetAutoCalcFields("Participant Name");
        SeminarRegistrationLine.FindFirst();
        repeat
            LineCount += 1;
            DialogWindow.Update(2, LineCount);
            SeminarRegistrationLine.TestField("Bill-to Customer No.");
            SeminarRegistrationLine.TestField("Participant Contact No.");
            if not SeminarRegistrationLine."To Invoice" then begin
                SeminarRegistrationLine."Seminar Price" := 0;
                SeminarRegistrationLine."Line Discount %" := 0;
                SeminarRegistrationLine."Line Discount Amount" := 0;
                SeminarRegistrationLine.Amount := 0;
            end;
            JobLedgEntryNo := PostJobJnlLine(SeminarJournalLine."Option Type");
            //SeminarLedgerEntryNo := PostSeminarJnlLine(SeminarLedgerEntry."Option Type", JobLedgEntryNo);
            PostedSeminarRegLine.Init();
            PostedSeminarRegLine.TransferFields(SeminarRegistrationLine);
            PostedSeminarRegLine."Seminar Registration No." := PostedSeminarRegHeader."No.";
            PostedSeminarRegLine.Insert();
            JobLedgEntryNo := 0;
        //SeminarLedgerEntryNo := 0;
        until SeminarRegistrationLine.Next() = 0;
        PostCharge();
        PostSeminarJnlLine(OptionType::Instructor, 0);
        PostSeminarJnlLine(OptionType::Room, 0);
        SeminarRegistrationLine.LockTable();
        SeminarRegistrationHeader.DeleteAll();
        Rec := SeminarRegistrationHeader;
    end;
    #endregion

    #region 4-178 punkt 4
    local procedure CopyCommentLines(FromTableNameID: Integer;
        ToTableNameID: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
        CommentLine.SetRange("Table Name", FromTableNameID);
        CommentLine.SetRange("No.", FromNumber);

        if CommentLine.FindSet() then
            repeat
                CommentLine2.Init();
                CommentLine2.TransferFields(CommentLine);
                CommentLine2."Table Name" := "Comment Line Table Name".FromInteger(ToTableNameID);
                CommentLine2."No." := ToNumber;
                CommentLine2.Insert();
            until CommentLine.Next() = 0;
    end;
    #endregion

    #region 4-178 punkt 5
    local procedure CopyCharges(FromNumber: Code[20]; ToNumber: Code[20])
    begin
        SeminarCharge.SetRange("Seminar Registration No.", FromNumber);

        if SeminarCharge.FindFirst() then
            repeat
                PostedSeminarCharge.Init();
                PostedSeminarCharge.TransferFields(SeminarCharge);
                PostedSeminarCharge."Seminar Registration No." := ToNumber;
                PostedSeminarCharge.Insert();
            until SeminarCharge.Next() = 0;
    end;
    #endregion

    #region
    local procedure PostJobJnlLine(OptionType: Enum "Option Type"): Integer
    begin
        #region clump A side 179
        if JobJournalLine."Seminar Registration No." = '' then exit(0); // <-----------------
        SeminarRegistrationHeader.Get(JobJournalLine."Seminar Registration No.");
        Customer.Get(SeminarRegistrationLine."Bill-to Customer No.");
        Instructor.Get(SeminarRegistrationHeader."Instructor Code");
        Resource.Get(Instructor."Resource No.");
        #endregion

        #region clump A side 180
        JobJournalLine.Init();
        JobJournalLine."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
        JobJournalLine."Entry Type" := "Job Journal Line Entry Type"::Usage;
        JobJournalLine."Document No." := PostedSeminarRegHeader."No.";
        JobJournalLine."Seminar Registration No." := PostedSeminarRegHeader."No.";
        JobJournalLine."Source Code" := SourceCode;
        JobJournalLine."Source Currency Total Cost" := SeminarRegistrationLine."Seminar Price";
        #endregion

        JobJournalLine."Job No." := SeminarRegistrationHeader."Job No.";
        JobJournalLine."Posting Date" := SeminarRegistrationHeader."Posting Date";
        JobJournalLine."Document Date" := SeminarRegistrationHeader."Document Date";
        JobJournalLine.Type := JobJournalLine.Type::Resource;
        JobJournalLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        JobJournalLine."No." := Resource."No.";
        JobJournalLine."Gen. Prod. Posting Group" := SeminarRegistrationHeader."Gen. Prod. Posting Group";

        case OptionType of
            OptionType::Participant:
                begin
                    JobJournalLine.Description := SeminarRegistrationLine."Participant Name";
                    JobJournalLine."No." := Instructor."Resource No.";
                    JobJournalLine."Unit of Measure Code" := Resource."Base Unit of Measure";
                    JobJournalLine.Chargeable := SeminarRegistrationLine."To Invoice";
                    JobJournalLine.Quantity := 1;
                    JobJournalLine."Unit Cost" := 0;
                    JobJournalLine."Total Cost" := 0;
                    JobJournalLine."Total Cost (LCY)" := 0;
                    JobJournalLine."Unit Price" := SeminarRegistrationLine.Amount;
                    JobJournalLine."Total Price" := SeminarRegistrationLine.Amount;
                    JobJournalLine."Total Price (LCY)" := SeminarRegistrationLine.Amount;
                end;
            OptionType::Charge:
                begin
                    JobJournalLine.Description := SeminarCharge.Description;
                    if SeminarCharge."Charge Type" = SeminarCharge."Charge Type"::"G/L Account" then begin
                        JobJournalLine.Type := "Job Journal Line Type"::"G/L Account";
                        JobJournalLine.Chargeable := SeminarCharge."To Invoice";
                        JobJournalLine."Quantity (Base)" := 1;
                        JobJournalLine."Unit Cost" := 0;
                        JobJournalLine."Total Cost" := 0;
                        JobJournalLine.Quantity := SeminarCharge.Quantity;
                        JobJournalLine."Unit Price" := SeminarCharge."Unit Price";
                        JobJournalLine."Total Price" := SeminarCharge."Total Price";
                    end else begin
                        JobJournalLine.Type := "Job Journal Line Type"::Resource;
                        JobJournalLine."Qty. per Unit of Measure" := SeminarCharge."Qty. per Unit of Measure";
                    end;
                    JobJournalLine."No." := SeminarCharge."No.";
                end;
        end;

        JobtaskLine.Reset();
        JobtaskLine.SetRange("Job No.", JobJournalLine."Job No.");
        JobtaskLine.FindFirst();
        JobJournalLine."Job Task No." := JobtaskLine."Job Task No.";
        exit(JobJnlPostLine.RunWithCheck(JobJournalLine));
    end;
    #endregion

    #region functions

    local procedure PostCharge()
    begin
        SeminarCharge.SetRange("Seminar Registration No.", SeminarRegistrationHeader."No.");
        if SeminarCharge.FindFirst() then
            repeat
                JobLedgEntryNo := PostJobJnlLine("Option Type"::Charge);
                PostSeminarJnlLine("Option Type"::Charge, JobLedgEntryNo);
                JobLedgEntryNo := 0;
            until SeminarCharge.Next() = 0;
    end;

    local procedure PostSeminarJnlLine(OptionType: Enum "Option Type"; JobLedgerEntryNo: Integer): Integer
    begin
        SeminarJournalLine.Init();

        SeminarJournalLine."Seminar No." := SeminarRegistrationHeader."Seminar No.";
        SeminarJournalLine."Document Date" := SeminarRegistrationHeader."Document Date";
        SeminarJournalLine."Posting Date" := SeminarRegistrationHeader."Posting Date";
        SeminarJournalLine."Document No." := SeminarRegistrationHeader."Posting No.";
        SeminarJournalLine."Job No." := SeminarRegistrationHeader."Job No.";
        SeminarJournalLine."Instructor Code" := SeminarRegistrationHeader."Instructor Code";
        SeminarJournalLine."Seminar Room Code" := SeminarRegistrationHeader."Instructor Code";
        SeminarJournalLine."Job Ledger Entry No." := JobLedgerEntryNo;
        SeminarJournalLine."Option Type" := OptionType;
        case OptionType of
            OptionType::Instructor:
                begin
                    SeminarRegistrationHeader.TestField(Duration);
                    SeminarJournalLine.Description := Instructor.Name;
                    SeminarJournalLine."Charge Type" := SeminarJournalLine."Charge Type"::Resource;
                    SeminarJournalLine.Chargeable := false;
                    SeminarJournalLine.Quantity := SeminarRegistrationHeader.Duration;
                end;
            OptionType::Room:
                begin
                    SeminarRegistrationHeader.TestField(Duration);
                    SeminarJournalLine.Description := SeminarRoom.Name;
                    SeminarJournalLine."Charge Type" := SeminarJournalLine."Charge Type"::Resource;
                    SeminarJournalLine.Chargeable := false;
                    SeminarJournalLine.Quantity := SeminarRegistrationHeader.Duration;
                end;
            OptionType::Participant:
                begin
                    SeminarJournalLine."Bill-to Customer No." := SeminarRegistrationLine."Bill-to Customer No.";
                    SeminarJournalLine."Participant Contact No." := SeminarRegistrationLine."Participant Contact No.";
                    SeminarJournalLine."Charge Type" := SeminarJournalLine."Charge Type"::Resource;
                    SeminarJournalLine.Chargeable := SeminarRegistrationLine."To Invoice";
                    SeminarJournalLine.Quantity := 1;
                    SeminarJournalLine."Unit Price" := SeminarRegistrationLine.Amount;
                    SeminarJournalLine."Total Price" := SeminarRegistrationLine.Amount;
                    SeminarJournalLine.TestField("Job Ledger Entry No.");
                end;
            OptionType::Charge:
                begin
                    SeminarJournalLine.Description := SeminarCharge.Description;
                    SeminarJournalLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJournalLine."Charge Type" := SeminarCharge."Charge Type";
                    SeminarJournalLine.Quantity := SeminarCharge.Quantity;
                    SeminarJournalLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJournalLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJournalLine.Chargeable := SeminarCharge."To Invoice";
                end;
        end;

        exit(SeminarJnlPostLine.RunWithCheck(SeminarJournalLine));
    end;
    #endregion functions

}
