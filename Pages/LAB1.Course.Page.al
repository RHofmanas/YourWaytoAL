page 50100 "Course"
{
    Caption = 'Course';
    PageType = Card;
    SourceTable = "Course Information";
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Name"; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Description"; rec.Description)
                {
                    ApplicationArea = all;
                }

            }
            group(Details)
            {
                field("Type"; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Duration"; rec.Duration)
                {
                    ApplicationArea = all;
                }
                field("Price"; rec.Price)
                {
                    ApplicationArea = all;
                }
                field("Active"; rec.Active)
                {
                    ApplicationArea = all;
                }
                field("Difficulty"; rec.Difficulty)
                {
                    ApplicationArea = all;
                }
                field("Passing Rate"; rec."Passing Rate")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Open Course List")
            {
                Caption = 'Course List';
                //Image = List;
                //Promoted = true;
                //PromotedCategory = Process;
                //PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = Page 50101;
            }
        }
    }

    /*
    trigger OnOpenPage()
    begin
        course.init();
        course.code := '8040';
        course.Name := 'Installation & Configuration';
        course.Description := 'Basic knowledge on installation and configuration';
        course.type := course.Type::"Remote Training";
        course.Duration := 2;
        course.Price := 1000;
        course.Active := true;
        course.Difficulty := 5;
        course."Passing Rate" := 75;
        course.insert();

        course.code := '8041';
        course.Name := 'Finance';
        course.Description := 'Basic knowledge on finance';
        course.type := course.Type::"Instructor led";
        course.Duration := 3;
        course.Price := 1500;
        course.Active := true;
        course.Difficulty := 7;
        course."Passing Rate" := 80;
        course.insert();

        course.code := '8042';
        course.Name := 'Your way to AL';
        course.Description := 'Introduction to programming';
        course.type := course.Type::"Instructor led";
        course.Duration := 5;
        course.Price := 2500;
        course.Active := true;
        course.Difficulty := 8;
        course."Passing Rate" := 80;
        course.insert();

        course.code := '8043';
        course.Name := 'Introduction';
        course.Description := 'Introduction to Microsoft Bussiness Central';
        course.type := course.Type::"Remote Training";
        course.Duration := 2;
        course.Price := 1000;
        course.Active := true;
        course.Difficulty := 4;
        course."Passing Rate" := 60;
        course.insert();

        course.code := '8044';
        course.Name := 'Application Setup';
        course.Description := 'Basic knowledge on application setup';
        course.type := course.Type::" e-Learning";
        course.Duration := 2;
        course.Price := 1000;
        course.Active := true;
        course.Difficulty := 5;
        course."Passing Rate" := 65;
        course.insert();

        course.code := '8045';
        course.Name := 'Bussiness Inteligence';
        course.Description := 'Basic knowledge on Bussiness Inteligence';
        course.type := course.Type::" e-Learning";
        course.Duration := 1;
        course.Price := 500;
        course.Active := true;
        course.Difficulty := 5;
        course."Passing Rate" := 65;
        course.insert();

        course.code := '8046';
        course.Name := 'Developers Guide to AL';
        course.Description := 'Advanced topics in programming';
        course.type := course.Type::"Instructor led";
        course.Duration := 10;
        course.Price := 2500;
        course.Active := true;
        course.Difficulty := 10;
        course."Passing Rate" := 75;
        course.insert();
    end;

    var
        course: Record "Course Information";
    */
}