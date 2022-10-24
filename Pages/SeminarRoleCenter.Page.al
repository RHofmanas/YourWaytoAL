page 50012 "Seminar Role Center"
{
    Caption = 'Seminar Role Center';
    PageType = RoleCenter;
    SourceTable = "Seminar Cue";

    layout
    {
        area(RoleCenter)
        {
            part("Seminar Activities"; "Seminar Activities")
            {
                Caption = 'Seminar Activities';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {

            group(History)
            {
                Caption = 'History';
                Image = History;
                action(PostedSeminarRegistrations)
                {
                    Caption = 'Posted Seminar Registrations';
                    RunObject = Page "Posted Seminar Registration";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted Seminar Registrations action.';
                }
                action(PostedSeminarCharges)
                {
                    Caption = 'Posted Seminar Charges';
                    RunObject = Page "Posted Seminar Charges";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted Seminar Charges action.';
                }
                action(SeminarRegisters)
                {
                    Caption = 'Seminar Registers';
                    RunObject = Page "Seminar Registers";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Seminar Registers action.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                action(Dimensions)
                {
                    caption = 'Dimensions';
                    ApplicationArea = All;
                    RunObject = page Dimensions;
                    ToolTip = 'Executes the Dimensions action.';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action(SeminarSetup)
                {
                    Caption = 'Seminar Setup';
                    ApplicationArea = All;
                    RunObject = page "Seminar Setup";
                    ToolTip = 'Executes the Seminar Setup action.';
                }
                action(ResourceList)
                {
                    Caption = 'Resources';
                    ApplicationArea = All;
                    RunObject = page "Resource List";
                    ToolTip = 'Executes the Resources action.';
                }
                action(Instructors)
                {
                    Caption = 'Instructors';
                    ApplicationArea = All;
                    RunObject = page Instructors;
                    ToolTip = 'Executes the Instructors action.';
                }
                action("No. Series")
                {
                    Caption = 'No. Series';
                    ApplicationArea = All;
                    RunObject = page "No. Series";
                    ToolTip = 'Executes the No. Series action.';
                }
                action("Report Selections")
                {
                    Caption = 'Report Selections';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Report Selections action.';
                    RunObject = Page "Report Selection-Seminar";
                }
            }
        }
        area(Embedding)
        {
            action(CustomerList)
            {
                Caption = 'Customers';
                ApplicationArea = All;
                RunObject = Page "Customer List";
                ToolTip = 'Executes the Customers action.';
            }
            action(SeminarList)
            {
                Caption = 'Seminars';
                ApplicationArea = All;
                RunObject = Page "Seminar List";
                ToolTip = 'Executes the Seminars action.';
            }
            action(SeminarRoomList)
            {
                Caption = 'Seminar Rooms';
                ApplicationArea = All;
                RunObject = Page "Seminar Room List";
                ToolTip = 'Executes the Seminar Rooms action.';
            }
            action(SeminarRegistrationList)
            {
                Caption = 'Seminar Registrations';
                ApplicationArea = All;
                RunObject = Page "Seminar Registration List";
                ToolTip = 'Executes the Seminar Registrations action.';
            }
            action(SalesInvoiceList)
            {
                Caption = 'Sales Invoices';
                ApplicationArea = All;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Executes the Sales Invoices action.';
            }
        }
        area(Creation)
        {
            action(NewSeminar)
            {
                Caption = 'Seminar';
                ApplicationArea = All;
                RunObject = Page "Seminar List";
                ToolTip = 'Executes the Seminar action.';
            }
            action(NewSeminarRegistration)
            {
                Caption = 'Seminar Registration';
                ApplicationArea = All;
                RunObject = Page "Seminar Registration";
                ToolTip = 'Executes the Seminar Registration action.';
            }
            action(NewSalesInvoice)
            {
                Caption = 'Sales Invoice';
                ApplicationArea = All;
                ToolTip = 'Executes the Sales Invoice action.';
            }
            action(FindEntries)
            {
                Caption = 'Find Entries';
                ApplicationArea = All;
                ToolTip = 'Executes the Find Entries action.';
            }
        }
        area(Reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("SeminarReg.-Participant List")
                {
                    Caption = 'Seminar Reg. - Participant List';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Seminar Reg. - Participant List action.';
                    //RunObject = Page "Seminar Reg. Participant List";
                }
                action("Seminar Reg. Participant Certificate")
                {
                    Caption = 'Seminar Reg. Participant Certificate';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Seminar Reg. Participant Certificate action.';
                    //RunObject = Page "Seminar Reg. Part. Certificate";
                }
            }
        }
    }
}

profile "Seminar Profile"
{
    Description = 'Some internal comment that only Dev can see';
    Caption = 'Seminar Profile';
    ProfileDescription = 'Use this Role Center to administrate the Seminar App within BC';
    RoleCenter = "Seminar Role Center";
    Enabled = true;
    Promoted = true;
}