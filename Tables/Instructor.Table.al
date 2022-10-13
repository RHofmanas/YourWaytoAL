table 50001 Instructor
{
    Caption = 'Instructor';
    DataClassification = ToBeClassified;
    LookupPageId = Instructors;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }
        field(2; Name; Text[80])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            OptionMembers = Internal,External;
        }
        field(4; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            DataClassification = SystemMetadata;
            TableRelation = Resource where(Type = const(Person));
            trigger OnValidate()
            begin
                if Resource.get("Resource No.") then
                    Name := Resource.Name
                else
                    Name := '';
            end;
        }
        field(5; "Contact No."; Code[20])
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
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        Resource: Record Resource;
        Contact: Record Contact;
}
