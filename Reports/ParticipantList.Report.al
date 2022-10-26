report 50000 "Participant List"
{
    ApplicationArea = All;
    Caption = 'Participant List';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'RDLC\ParticipantList.rdl';

    dataset
    {
        dataitem(SeminarRegistrationHeader; "Seminar Registration Header")
        {
            RequestFilterFields = "No.", "Seminar No.", "Starting Date";
            DataItemTableView = sorting("No.");

            column(No; "No.")
            {
            }
            column(SeminarNo; "Seminar No.")
            {
            }
            column(SeminarName; "Seminar Name")
            {
            }
            column(StartingDate; "Starting Date")
            {
            }
            column(Duration; "Duration")
            {
            }
            column(InstructorName; "Instructor Name")
            {
            }
            column(SeminarRoomName; "Seminar Room Name")
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(ReportCaption; ReportCaptionLbl)
            {
            }
            dataitem(SeminarRegistrationLine; "Seminar Registration Line")
            {
                DataItemLinkReference = SeminarRegistrationHeader;
                DataItemLink = "Seminar Registration No." = field("No.");
                column(ParticipantName; "Participant Name")
                {
                }
                column(ParticipantContactNo; "Participant Contact No.")
                {
                }
                column(BillToCustomerNo; "Bill-to Customer No.")
                {
                }
                column(Registered; Registered)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Instructor Name");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        ReportCaptionLbl: label 'Participant List';
}