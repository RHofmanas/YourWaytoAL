#pragma warning disable LC0015
xmlport 50000 "Sem. Reg.-Participant List"
#pragma warning restore LC0015
{
    Caption = 'Sem. Reg.-Participant List';
    Format = XML;
    Direction = Export;

    schema
    {
        textelement(Seminar_Registration_Participant_List)
        {
            tableelement(Seminar; "Seminar Registration Header")
            {
                fieldelement(No; Seminar."No.")
                {
                }
                fieldelement(SeminarNo; Seminar."Seminar No.")
                {
                }
                fieldelement(SeminarName; Seminar."Seminar Name")
                {
                }
                fieldelement(StartingDate; Seminar."Starting Date")
                {
                }
                fieldelement(Duration; Seminar."Duration")
                {
                }
                fieldelement(InstructorName; Seminar."Instructor Name")
                {
                }
                fieldelement(SeminarRoomName; Seminar."Seminar Room Name")
                {
                }
                tableelement(Participant; "Seminar Registration Line")
                {
                    fieldelement(Customer_No; Participant."Bill-to Customer No.")
                    {
                    }
                    fieldelement(Contact_No; Participant."Participant Contact No.")
                    {
                    }
                    fieldelement(Name; Participant."Participant Name")
                    {
                    }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
