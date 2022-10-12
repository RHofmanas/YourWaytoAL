codeunit 50020 "Seminar-Post"
{
    TableNo = "Seminar Registration Header";

    #region 
    trigger OnRun()
    var
        RecRef: RecordRef;
        RecID: RecordId;
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
        OptionType: enum "Option Type";
    begin
        ClearAll();
        SeminarRegHeader := Rec;

        ////////////////////////////////////////TEST/////////////////
        SeminarRegHeader."Posting Date" := Today;
        SeminarRegHeader."Starting Date" := Today;
        SeminarRegHeader."Document Date" := Today;
        SeminarRegHeader."Seminar No." := 'D';
        SeminarRegHeader."No." := 'D';
        SeminarRegHeader.Duration := 10;
        SeminarRegHeader."Instructor Code" := 'D';
        SeminarRegHeader."Seminar Room Code" := 'D';
        SeminarRegHeader."Job No." := 'GH';
        //////////////////////////////////////END TEST///////////////
        SeminarRegHeader.TestField("Posting Date");
        SeminarRegHeader.TestField("Document Date");
        SeminarRegHeader.TestField("Starting Date");
        SeminarRegHeader.TestField("Seminar No.");
        SeminarRegHeader.TestField(Duration);
        SeminarRegHeader.TestField("Instructor Code");
        SeminarRegHeader.TestField("Seminar Room Code");
        SeminarRegHeader.TestField("Job No.");
        SeminarRegHeader.TestField(SeminarRegHeader.Status, "Seminar Reg. Status"::Closed);

        Instructor.Get(SeminarRegHeader."Instructor Code");
        Instructor.TestField("Resource No.");

        SeminarRoom.Get(SeminarRegHeader."Seminar Room Code");
        SeminarRoom.TestField("Resource No.");

        SeminarRegLine.reset();
        SeminarRegLine.SetRange("Seminar Registration No.", SeminarRegHeader."No.");

        If SeminarRegLine.IsEmpty then
            Error(SeminarRegLineEmptyLbl, SeminarRegLine.TableCaption, SeminarRegHeader.TableCaption);

        Window.open(PostingLbl + SemRegLbl + LineCounterLbl);
        window.update(1, SeminarRegHeader."No.");

        if SeminarRegHeader."Posting No." = '' then begin
            if SeminarRegHeader."Posting No. Series" = '' then begin
                SeminarSetup.get();
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                SeminarRegHeader."Posting No. Series" := SeminarSetup."Posted Seminar Reg. Nos.";
            end;

            SeminarRegHeader."Posting No." := NoSeriesManagement.GetNextNo(SeminarRegHeader."Posting No. series", SeminarRegHeader."Posting Date", true);
            SeminarRegHeader.modify();
            Commit();

        end;

        SeminarRegLine.LockTable();
        SeminarLedgerEntry.LockTable();
        SeminarLedgerEntryNo := SeminarLedgerEntry.GetLastEntryNo();
        SourceCodeSetup.get();
        SourceCode := SourceCodeSetup.Seminar;

        PstdSeminarRegHeader.Init();
        PstdSeminarRegHeader.TransferFields(SeminarRegHeader);
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := UserId();
        PstdSeminarRegHeader.Insert();
        CopyCommentLines(CommentLine."Table Name"::"Seminar Registration Header".AsInteger(),
        CommentLine."Table Name"::"Posted Seminar Registration".AsInteger(), SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        SeminarRegLine.SetAutoCalcFields("Participant Name");
        SeminarRegLine.FindFirst();
        repeat
            LineCount += 1;
            Window.update(2, LineCount);

            SeminarRegLine.TestField("Bill-to Customer No.");
            SeminarRegLine.TestField("Participant Contact No.");
            If not SeminarRegLine."To Invoice" then begin
                SeminarRegLine."Seminar Price" := 0;
                SeminarRegLine."Line Discount %" := 0;
                SeminarRegLine."Line Discount Amount" := 0;
                SeminarRegLine.Amount := 0;
            end;

            JobLedgEntryNo := PostJobJnlLine(SeminarJnlLine."Option Type");
            SeminarLedgerEntryNo := PostSeminarJnlLine(SeminarLedgerEntry."Option Type", JobLedgEntryNo);

            PstdSeminarRegLine.Init();
            PstdSeminarRegLine.TransferFields(SeminarRegLine);
            PstdSeminarRegLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
            PstdSeminarRegLine.Insert();
            JobLedgEntryNo := 0;
            SeminarLedgerEntryNo := 0;

        until SeminarRegLine.Next() = 0;
        PostCharge();
        PostSeminarJnlLine(OptionType::Instructor, 0);
        PostSeminarJnlLine(OptionType::Room, 0);

        SeminarRegLine.LockTable();
        SeminarRegHeader.DeleteAll();
        SeminarRegHeader := Rec;

    end;
    #endregion

    #region 4-178 punkt 4
    local procedure CopyCommentLines(FromTableNameID: Integer;
        ToTableNameID: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
        CommentLine.setrange("Table Name", FromTableNameID);
        CommentLine.setrange("No.", FromNumber);

        if CommentLine.Findset() then
            repeat
                CommentLine2.Init();
                CommentLine2.TransferFields(CommentLine);
                CommentLine2."Table Name" := "Comment Line Table Name".FromInteger(ToTableNameID);
                CommentLine2."No." := ToNumber;
                CommentLine2.insert();
            until CommentLine.Next() = 0;
    end;
    #endregion

    #region 4-178 punkt 5
    local procedure CopyCharges(FromNumber: Code[20]; ToNumber: Code[20])
    begin
        SeminarCharge.SetRange("Seminar Registration No.", FromNumber);

        if SeminarCharge.FindSet() then
            repeat
                PstdSeminarCharge.Init();
                PstdSeminarCharge.TransferFields(SeminarCharge);
                PstdSeminarCharge."Seminar Registration No." := ToNumber;
                PstdSeminarCharge.Insert();
            until CommentLine.Next() = 0;
    end;
    #endregion

    #region
    local procedure PostJobJnlLine(OptionType: enum "Option Type") JobLedgEntryNo: Integer
    begin
        Customer.Get(SeminarRegLine."Bill-to Customer No.");

        case OptionType of
            OptionType::Instructor, OptionType::Participant:
                Resource.get(Instructor."Resource No.");
            OptionType::Room:
                resource.get(SeminarRoom."Resource No.");
        end; //case

        Instructor.Get(SeminarRegHeader."Instructor Code");
        Resource.Get(Instructor."Resource No.");

        JobJnlLine.Init();
        JobJnlLine."Job No." := SeminarRegHeader."Job No.";
        JobJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        JobJnlLine."Document Date" := SeminarRegHeader."Document Date";
        JobJnlLine."Document No." := PstdSeminarRegHeader."No.";
        JobJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        JobJnlLine.type := JobJnlLine.type::Resource;


        case OptionType of
            OptionType::Participant:
                begin
                    JobJnlLine.Description := SeminarRegLine."Participant Name";
                    JobJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    JobJnlLine.Quantity := 1;
                    JobJnlLine."Unit Cost" := 0;
                    JobJnlLine."Total Cost" := 0;
                    JobJnlLine."Total Cost (LCY)" := 0;
                    JobJnlLine."Unit Price" := SeminarRegLine.Amount;
                    JobJnlLine."Total Price" := SeminarRegLine.Amount;
                    JobJnlLine."Total Price (LCY)" := SeminarRegLine.Amount;
                end;
            OptionType::Charge:
                begin
                    JobJnlLine.Description := SeminarCharge.Description;
                    if SeminarCharge."Charge Type" = SeminarCharge."Charge Type"::"G/L Account" then begin
                        JobJnlLine.Type := "Job Journal Line Type"::"G/L Account";
                        JobJnlLine.Chargeable := SeminarCharge."To Invoice";
                        JobJnlLine."Quantity (Base)" := 1;
                        JobJnlLine."Unit Cost" := 0;
                        JobJnlLine."Total Cost" := 0;
                        JobJnlLine.Quantity := SeminarCharge.Quantity;
                        JobJnlLine."Unit Price" := SeminarCharge."Unit Price";
                        JobJnlLine."Total Price" := SeminarCharge."Total Price";
                    end else begin
                        JobJnlLine.Type := "Job Journal Line Type"::Resource;
                        JobJnlLine."Qty. per Unit of Measure" := SeminarCharge."Qty. per Unit of Measure";
                    end;
                    JobJnlLine."No." := SeminarCharge."No.";
                end;

        end;


        JobJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        JobJnlLine."No." := Resource."no.";
        JobJnlLine."Entry Type" := "Job Journal Line Entry Type"::Usage;
        JobJnlLine."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
        JobJnlLine."Gen. Prod. Posting Group" := SeminarRegHeader."Gen. Prod. Posting Group";
        JobJnlLine."Source Code" := SourceCode;
        JobJnlLine."Source Currency Total Cost" := SeminarRegLine."Seminar Price";
        JobtaskLine.reset();
        JobtaskLine.setrange("Job No.", JobJnlLine."Job No.");
        JobtaskLine.findfirst();
        JobJnlLine."Job Task No." := JobtaskLine."Job Task No.";

        exit(JobJnlPostLine.RunWithCheck(JobJnlLine));

    end;
    #endregion

    local procedure PostSeminarJnlLine(OptionType: Enum "Option Type"; JobLedgerEntryNo: Integer): Integer
    begin
        SeminarJnlLine.Init();
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document No." := SeminarRegHeader."Posting No.";
        SeminarJnlLine."Job No." := SeminarRegHeader."Job No.";
        SeminarJnlLine."Instructor Code" := SeminarRegHeader."Instructor Code";
        SeminarJnlLine."Seminar Room Code" := SeminarRegHeader."Instructor Code";
        SeminarJnlLine."Job Ledger Entry No." := JobLedgerEntryNo;
        SeminarJnlLine."Option Type" := OptionType;
        case OptionType of
            OptionType::Instructor:
                begin
                    SeminarRegHeader.testfield(Duration);
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine."Charge Type" := SeminarJnlLine."Charge Type"::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                end;
            OptionType::Room:
                begin
                    SeminarRegHeader.testfield(Duration);
                    SeminarJnlLine.Description := SeminarRoom.Name;
                    SeminarJnlLine."Charge Type" := SeminarJnlLine."Charge Type"::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                end;
            OptionType::Participant:
                begin
                    SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Charge Type" := SeminarJnlLine."Charge Type"::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                    SeminarJnlLine.testfield("Job Ledger Entry No.");
                end;
            OptionType::Charge:
                begin
                    SeminarJnlLine.Description := SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine."Charge Type" := SeminarCharge."Charge Type";
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                end;
        end;

        exit(SeminarJnlPostLine.RunWithCheck(SeminarJnlLine));
    end;


    local procedure PostCharge()
    begin
        if SeminarCharge.Find('-') then
            repeat
                if (SeminarCharge."Job No." = SeminarRegHeader."Job No.") then begin
                    JobLedgEntryNo := PostJobJnlLine("Option Type"::Charge);
                    PostSeminarJnlLine("Option Type"::Charge, JobLedgEntryNo);
                    JobLedgEntryNo := 0;
                end;
            until CommentLine.Next() = 0;
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        PstdSeminarRegHeader: Record "Posted Seminar Reg. Header";
        PstdSeminarRegLine: Record "Posted Seminar Reg. Line";
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        CommentLine2: Record "Comment Line";
        SeminarCharge: Record "Seminar Charge";
        PstdSeminarCharge: Record "Posted Seminar Charge";
        SeminarRoom: Record "Seminar Room";
        Instructor: Record Instructor;
        Job: Record Job;
        Resource: Record Resource;
        Customer: Record Customer;
        JobLedgEntry: Record "Job Ledger Entry";
        JobJnlLine: Record "Job Journal Line";
        JobtaskLine: record "Job Task";
        SeminarJnlLine: Record "Seminar Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        SeminarJnlPostLine: Codeunit "Seminar Jnl.-Post Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ModifyHeader: Boolean;
        Window: Dialog;
        SourceCode: Code[10];
        LineCount: Integer;
        JobLedgEntryNo: Integer;
        SeminarLedgerEntryNo: Integer;
        SeminarRegLineEmptyLbl: label 'There are no records in the table %1 associated with this %2';

        PostingLbl: Label 'Posting... \';
        SemRegLbl: label 'Seminar Reg. #1#####\';
        LineCounterLbl: label 'Line No. #2#####';

}
