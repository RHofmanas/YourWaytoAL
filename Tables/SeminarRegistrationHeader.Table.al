table 50004 "Seminar Registration Header"
{
    Caption = 'Seminar Registration Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Registration List";
    DrillDownPageId = "Seminar Registration List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    SeminarSetup.Get;
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Registrant Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Rec.Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;
            TableRelation = Seminar;
            trigger OnValidate()
            var
                Seminar: Record Seminar;
                SeminarRegLineExistsErrLbl: Label 'You can not change the field %1, because one or more %2 exists';
            begin
                if (xRec."Seminar No." <> '') and (Rec."Seminar No." <> xRec."Seminar No.") then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Seminar Registration No.", Rec."No.");
                    if not SeminarRegLine.IsEmpty() then
                        Error(SeminarRegLineExistsErrLbl, FieldCaption("Seminar No."), SeminarRegLine.TableCaption);
                end;

                if Seminar.Get("Seminar No.") then begin
                    Seminar.TestField(Blocked, false);
                    Seminar.TestField("Gen. Prod. Posting Group");
                    Seminar.TestField("VAT Prod. Posting Group");
                    Rec."Seminar Name" := Seminar.Name;
                    Rec.Duration := Seminar."Seminar Duration";
                    Rec."Seminar Price" := Seminar."Seminar Price";
                    Rec."Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                    Rec."VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                    Rec."Maximum Participants" := Seminar."Maximum Participants";
                    Rec."Minimum Participants" := Seminar."Minimum Participants";
                    Rec.Validate("Job No.", Seminar."Job No.");
                end else
                    Rec."Seminar Name" := '';
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            DataClassification = ToBeClassified;
            TableRelation = Instructor;
            trigger OnValidate()
            var
                Instructor: Record Instructor;
            begin
                if Instructor.Get("Instructor Code") then
                    if ("Instructor Code" <> '') and ("Instructor Code" <> xRec."Instructor Code") then
                        "Instructor Name" := Instructor.Name;
            end;
        }

        field(6; "Instructor Name"; Text[80])
        {
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Instructor.Name where(Code = field("Instructor Code")));
        }

        field(7; Status; Enum "Seminar Reg. Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(8; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(11; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code';
            DataClassification = ToBeClassified;
            TableRelation = "Seminar Room";
            trigger OnValidate()
            var
                SeminarRoom: Record "Seminar Room";
                MaxParticipantsConfirm: Label '%1 for %2 are %3. The %4 only allows %5 participants. Do you want to change %1?';
            begin
                if SeminarRoom.Get("Seminar Room Code") then begin
                    "Seminar Room Name" := SeminarRoom.Name;
                    "Seminar Room Address" := SeminarRoom.Address;
                    "Seminar Room City" := SeminarRoom.City;
                    "Seminar Room Phone No." := SeminarRoom."Phone No.";
                    "Seminar Room Post Code" := SeminarRoom."Post Code";
                    if (CurrFieldNo <> 0) then
                        if (SeminarRoom."Maximum Participants" <> 0) and
                        (SeminarRoom."Maximum Participants" < Rec."Maximum Participants") then begin
                            if Confirm(MaxParticipantsConfirm, true, Rec.FieldCaption("Maximum Participants"),
                            Rec.TableCaption, "Maximum Participants", SeminarRoom.TableCaption, SeminarRoom."Maximum Participants")
                               then
                                "Maximum Participants" := SeminarRoom."Maximum Participants";
                        end;

                end else begin
                    "Seminar Room Name" := '';
                    "Seminar Room Address" := '';
                    "Seminar Room City" := '';
                    "Seminar Room Phone No." := '';
                    "Seminar Room Post Code" := '';
                end;
            end;
        }
        field(12; "Seminar Room Name"; Text[100])
        {
            Caption = 'Seminar Room Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Seminar Room Address"; Text[100])
        {
            Caption = 'Seminar Room Address';
            DataClassification = ToBeClassified;
        }
        field(14; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
                Country: Record "Country/Region";
            begin
                PostCode.ValidatePostCode(Rec."Seminar Room City", Rec."Seminar Room Post Code",
                Country."County Name", Country.Code, false);
            end;

            trigger OnLookup()
            var
                PostCode: Record "Post Code";
                Country: Record "Country/Region";
            begin
                PostCode.LookUpPostCode(Rec."Seminar Room City", Rec."Seminar Room Post Code",
                Country."County Name", Country.Code);
            end;
        }
        field(15; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City';
            DataClassification = ToBeClassified;
        }
        field(16; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(17; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            trigger OnValidate()
            var
                ConfirmPriceChange: Label 'Do you want to change the field 1% for table %2?';
            begin
                if (Rec."Seminar Price" <> xRec."Seminar Price") and
                (Rec.Status <> Rec.Status::Canceled) then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Seminar Registration No.", "No.");
                    SeminarRegLine.SetRange(Registered, false);
                    if SeminarRegLine.FindSet(false, false) then
                        if Confirm(ConfirmPriceChange, false, FieldCaption("Seminar Price"), SeminarRegLine.TableCaption) then begin
                            repeat
                                SeminarRegLine.Validate("Seminar Price", "Seminar Price");
                                SeminarRegLine.Modify();
                            until SeminarRegLine.Next() = 0;
                            Rec.Modify();
                        end;

                end;
            end;
        }
        field(18; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(20; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" Where("Table Name" = const("Seminar Registration Header"), "No." = field("No.")));
        }

        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(23; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
                SeminarCharge: Record "Seminar Charge";
                ConfirmChangeJobNo: Label 'Changing the 1% will change all records in the %2 table. Do you want to proceed?';
            begin
                if Job.Get("Job No.") then
                    Job.TestField(Blocked, Job.Blocked::" ");

                if "Job No." <> xRec."Job No." then begin
                    SeminarCharge.Reset();
                    SeminarCharge.SetCurrentKey("Job No.");
                    SeminarCharge.SetRange("Job No.", xRec."Job No.");
                    if SeminarCharge.FindSet(true, true) then begin
                        if Confirm(ConfirmChangeJobNo, true, FieldCaption("Job No."), SeminarCharge.TableCaption) then begin
                            SeminarCharge.ModifyAll("Job No.", "Job No.");
                            Modify();
                        end else begin
                            "Job No." := xRec."Job No.";
                        end;
                    end;
                end;
            end;
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(25; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(26; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "Posting No. Series" <> '' then begin
                    SeminarSetup.Get();
                    SeminarSetup.TestField("Seminar Registrant Nos.");
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                    NoSeriesManagement.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;

            trigger OnLookup()
            var
                SeminarRegHeader: Record "Seminar Registration Header";
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registrant Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesManagement.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series") then
                    Validate("Posting No. Series");
                Rec := SeminarRegHeader;
            end;
        }
        field(27; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key2; "Seminar Room Code")
        {
            SumIndexFields = Duration;
        }
    }
    procedure AssistEdit(OldSeminarRegHeader: Record "Seminar Registration Header"): Boolean
    var
        SeminarSetup: Record "Seminar Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        OldSeminarRegHeader := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", "No. Series") then begin
            NoSeriesManagement.SetSeries("No.");
            Rec := OldSeminarRegHeader;
            exit(true);
        end;
    end;

    procedure InitRecord()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Posted Seminar Reg. Nos.");
            NoSeriesManagement.SetDefaultSeries(
                SeminarSetup."Posted Seminar Reg. Nos.", "No. Series");
        end;
        "Document Date" := WorkDate();
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();
    end;

    trigger OnInsert()
    begin
        if Rec."No." = '' then begin
            SeminarSetup.get();
            SeminarSetup.TestField("Seminar Registrant Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Registrant Nos.",
            xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
        InitRecord();
    end;

    trigger OnDelete()
    var
        SeminarCharge: Record "Seminar Charge";
        DeleteTextError: Label 'You can not delete %1 %2, because one or more %3 where %4 = %5 exists.';
        SeminarChargeExistsError: Label 'You can not delete %1 %2, because one more %3 exists.';
    begin
        TestField(Status, Status::Canceled);
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Seminar Registration No.", "No.");
        SeminarRegLine.SetRange(Registered, true);
        if SeminarRegLine.Find('-') then
            Error(DeleteTextError, Rec.TableCaption, Rec."No.", SeminarRegLine.TableCaption,
            SeminarRegLine.FieldCaption(Registered), true);
        SeminarRegLine.SetRange(Registered);
        SeminarRegLine.DeleteAll(true);

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Seminar Registration No.", "No.");
        if not SeminarCharge.IsEmpty() then
            Error(SeminarChargeExistsError, Rec.TableCaption, Rec."No.", SeminarCharge.TableCaption);

        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"Seminar Registration Header");
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();
    end;

    trigger OnRename()
    var
        ErrorMsgLbl: Label 'The record %1 can not be renamed';
    begin
        Error(ErrorMsgLbl, TableCaption);
    end;

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SeminarRegLine: Record "Seminar Registration Line";
}
