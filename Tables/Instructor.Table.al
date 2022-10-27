
#pragma warning disable LC0015
table 50001 Instructor
#pragma warning restore LC0015

{
    Caption = 'Instructor';
    DataClassification = SystemMetadata;
    LookupPageId = Instructors;
    DrillDownPageId = Instructors;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Internal,External;
        }
        field(4; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource where(Type = const(Person));
            trigger OnValidate()
            begin
                if Resource.Get("Resource No.") then
                    Name := Resource.Name
                else
                    Name := '';
            end;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
            trigger OnValidate()
            begin
                if Contact.Get("Contact No.") then
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
