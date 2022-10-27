#pragma warning disable LC0015
report 50004 "MID example"
#pragma warning restore LC0015
{
    ApplicationArea = Basic, Suite;
    Caption = 'Participants List';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'RDLC\MIDexample.rdl';
    dataset
    {
        dataitem(SeminarRegistrationHeader; "Seminar Registration Header")
        {
            RequestFilterFields = "No.", "Starting Date";

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

                column(Participant_Name; "Participant Name")
                {

                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {

                }
                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {

                }
                column(Registered; Registered)
                {

                }
            }
            trigger OnAfterGetRecord()
            begin
                SeminarRegistrationHeader.CalcFields("Instructor Name");
            end;

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
    var
        ReportCaptionLbl: Label 'Participant List';
}
