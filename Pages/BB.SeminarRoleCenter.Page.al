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
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';
                Image = RegisteredDocs;
                action(PostedSalesInvoices)
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Service Invoices";
                    ApplicationArea = All;
                }
                action(PostedSales)
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = All;
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
                }
                action(ResourceList)
                {
                    Caption = 'Resources';
                    ApplicationArea = All;
                    RunObject = page "Resource List";
                }
                action(Instructors)
                {
                    Caption = 'Instructors';
                    ApplicationArea = All;
                    RunObject = page Instructors;
                }
                action("No. Series")
                {
                    Caption = 'No. Series';
                    ApplicationArea = All;
                    RunObject = page "No. Series";
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
            }
            action(SeminarList)
            {
                Caption = 'Seminars';
                ApplicationArea = All;
                RunObject = Page "Seminar List";
            }
            action(SeminarRoomList)
            {
                Caption = 'Seminar Rooms';
                ApplicationArea = All;
                RunObject = Page "Seminar Room List";
            }
            action(SeminarRegistrationList)
            {
                Caption = 'Seminar Registrations';
                ApplicationArea = All;
                RunObject = Page "Seminar Registration List";
            }
            action(SalesInvoiceList)
            {
                Caption = 'Sales Invoices';
                ApplicationArea = All;
                RunObject = Page "Sales Invoice List";
            }
        }
        area(Creation)
        {
            action(NewSeminar)
            {
                Caption = 'New Seminar';
                ApplicationArea = All;
                RunObject = Page "Seminar List";
            }
            action(NewSeminarRegistration)
            {
                Caption = 'New Seminar Registration';
                ApplicationArea = All;
                RunObject = Page "Seminar Registration";
            }
            action(NewSalesInvoice)
            {
                Caption = 'New Sales Invoice';
                ApplicationArea = All;
            }
            action(FindEntries)
            {
                Caption = 'Find Entries';
                ApplicationArea = All;
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