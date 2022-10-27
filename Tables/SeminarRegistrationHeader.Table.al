
#pragma warning disable LC0015
table 50004 "Seminar Registration Header"
#pragma warning restore LC0015

{
    Caption = 'Seminar Registration Header';
    DataClassification = SystemMetadata;
    LookupPageId = "Seminar Registration List";
    DrillDownPageId = "Seminar Registration List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Registrant Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Rec.Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
            trigger OnValidate()
            var
                Seminar: Record Seminar;
#pragma warning disable AA0470
                SeminarRegLineExistsErrLbl: Label 'You can not change the field %1, because one or more %2 exists';
#pragma warning restore AA0470
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
        field(4; "Seminar Name"; Text[80])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            TableRelation = Instructor;
            trigger OnValidate()
            var
                Instructor: Record Instructor;
            begin
                if Instructor.Get("Instructor Code") then
                    if ("Instructor Code" <> '') and ("Instructor Code" <> xRec."Instructor Code") then
                        "Instructor Name" := Instructor.Name; // 
            end;
        }

        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Instructor.Name where(Code = field("Instructor Code")));
        }

        field(7; Status; Enum "Seminar Reg. Status")
        {
            Caption = 'Status';
        }
        field(8; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(11; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code';
            TableRelation = "Seminar Room";
            trigger OnValidate()
            var
                SeminarRoom: Record "Seminar Room";
#pragma warning disable AA0470
                MaxParticipantsConfirmLbl: Label '%1 for %2 are %3. The %4 only allows %5 participants. Do you want to change %1?';
#pragma warning restore AA0470
            begin
                if SeminarRoom.Get("Seminar Room Code") then begin
                    "Seminar Room Name" := SeminarRoom.Name;
                    "Seminar Room Address" := SeminarRoom.Address;
                    "Seminar Room City" := SeminarRoom.City;
                    "Seminar Room Phone No." := SeminarRoom."Phone No.";
                    "Seminar Room Post Code" := SeminarRoom."Post Code";
                    if (CurrFieldNo <> 0) then
                        if (SeminarRoom."Maximum Participants" <> 0) and
                        (SeminarRoom."Maximum Participants" < Rec."Maximum Participants") then
#pragma warning disable LC0021
                            if Confirm(MaxParticipantsConfirmLbl, true, Rec.FieldCaption("Maximum Participants"),
                            Rec.TableCaption, "Maximum Participants", SeminarRoom.TableCaption, SeminarRoom."Maximum Participants")
#pragma warning restore LC0021
                               then
                                "Maximum Participants" := SeminarRoom."Maximum Participants"
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
        }
        field(13; "Seminar Room Address"; Text[100])
        {
            Caption = 'Seminar Room Address';
        }
        field(14; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code';
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
                PostCode.LookupPostCode(Rec."Seminar Room City", Rec."Seminar Room Post Code",
                Country."County Name", Country.Code);
            end;
        }
        field(15; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City';
        }
        field(16; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(17; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
            trigger OnValidate()
            var
#pragma warning disable AA0470
                ConfirmPriceChangeLbl: Label 'Do you want to change the field 1% for table %2?';
#pragma warning restore AA0470
            begin
                if (Rec."Seminar Price" <> xRec."Seminar Price") and
                (Rec.Status <> Rec.Status::Canceled) then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Seminar Registration No.", "No.");
                    SeminarRegLine.SetRange(Registered, false);
                    if SeminarRegLine.FindSet(false, false) then
#pragma warning disable LC0021
                        if Confirm(ConfirmPriceChangeLbl, false, FieldCaption("Seminar Price"), SeminarRegLine.TableCaption) then begin
#pragma warning restore LC0021
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
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(20; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = const("Seminar Registration Header"), "No." = field("No.")));
        }

        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(22; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(23; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
                SeminarCharge: Record "Seminar Charge";
#pragma warning disable AA0470
                ConfirmChangeJobNoLbl: Label 'Changing the 1% will change all records in the %2 table. Do you want to proceed?';
#pragma warning restore AA0470
            begin
                if Job.Get("Job No.") then
                    Job.TestField(Blocked, Job.Blocked::" ");

                if "Job No." <> xRec."Job No." then begin
                    SeminarCharge.Reset();
                    SeminarCharge.SetCurrentKey("Job No.");
                    SeminarCharge.SetRange("Job No.", xRec."Job No.");
                    if SeminarCharge.FindSet(true, true) then
#pragma warning disable LC0021
                        if Confirm(ConfirmChangeJobNoLbl, true, FieldCaption("Job No."), SeminarCharge.TableCaption) then begin
#pragma warning restore LC0021
                            SeminarCharge.ModifyAll("Job No.", "Job No.");
                            Modify();
                        end else
                            "Job No." := xRec."Job No.";
                end;
            end;
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(26; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
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
        }
        field(40; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
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
        key(key3; "Instructor Code", "Starting Date")
        {

        }
    }
#pragma warning disable AA0072
    procedure AssistEdit(OldSeminarRegHeader: Record "Seminar Registration Header"): Boolean
#pragma warning restore AA0072
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
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registrant Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Registrant Nos.",
            xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
        InitRecord();
    end;

    trigger OnDelete()
    var
        SeminarCharge: Record "Seminar Charge";
#pragma warning disable AA0074
#pragma warning disable AA0470
        DeleteTextError: Label 'You can not delete %1 %2, because one or more %3 where %4 = %5 exists.';
        SeminarChargeExistsError: Label 'You can not delete %1 %2, because one more %3 exists.';
#pragma warning restore AA0470
#pragma warning restore AA0074
    begin
        TestField(Status, Status::Canceled);
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Seminar Registration No.", "No.");
        SeminarRegLine.SetRange(Registered, true);
        if SeminarRegLine.FindFirst() then
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
#pragma warning disable AA0470
        ErrorMsgLbl: Label 'The record %1 can not be renamed';
#pragma warning restore AA0470
    begin
        Error(ErrorMsgLbl, TableCaption);
    end;

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
#pragma warning disable AA0072
        SeminarRegLine: Record "Seminar Registration Line";
#pragma warning restore AA0072
        NoSeriesManagement: Codeunit NoSeriesManagement;
}
