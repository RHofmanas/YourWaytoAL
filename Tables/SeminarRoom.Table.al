
// Reviewed, tested 04.10.22
table 50000 "Seminar Room"
{
    Caption = 'Seminar Room';
    DataClassification = CustomerContent;
    LookupPageId = "Seminar Room List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(5; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", false);
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", false);
            end;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/region";
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDataType = PhoneNo;
        }
        field(9; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
            DataClassification = CustomerContent;
            ExtendedDataType = PhoneNo;
        }
        field(10; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(11; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
        }
        field(12; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
            ExtendedDataType = EMail;
        }
        field(13; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(14; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ParticipantsCheck()
            end;
        }
        field(15; Alocation; Decimal)
        {
            Caption = 'Alocation';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(16; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            DataClassification = SystemMetadata;
            TableRelation = Resource where(Type = filter("Seminar Room"));
            trigger OnValidate()
            begin
                if Resource.get("Resource No.") then
                    Name := Resource.Name
                else
                    Name := '';
            end;
        }
        field(17; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula =
                exist("Comment Line" WHERE("Table Name" = const("Seminar Room"),
                "No." = field(Code)));
        }
        field(18; "Internal/External"; Option)
        {
            Caption = 'Internal/External';
            OptionMembers = Internal,External;
            DataClassification = SystemMetadata;
        }
        field(19; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = SystemMetadata;
            TableRelation = Contact;
            trigger OnValidate()
            begin
                if Contact.get("Contact No.") then
                    Name := Contact.Name;
            end;
        }
        field(20; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    procedure ParticipantsCheck()
    begin
        if "Maximum Participants" < 1 then
            Error('Enter number of participants')
    end;

    trigger OnInsert()
    begin
        ParticipantsCheck()
    end;

    trigger OnModify()
    begin
        ParticipantsCheck()
    end;

    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        ExtendedTextHeader: Record "Extended Text Header";
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"Seminar Room");
        CommentLine.SetRange("No.", Code);
        CommentLine.DeleteAll(true);
        ExtendedTextHeader.Reset();
        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Seminar Room");
        ExtendedTextHeader.SetRange("No.", Code);
        ExtendedTextHeader.DeleteAll(true);
    end;

    var
        PostCode: Record "Post Code";
        Resource: Record Resource;
        Contact: Record Contact;
}