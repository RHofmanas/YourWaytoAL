
#pragma warning disable LC0015
page 50021 "Instructor Class Overview"
#pragma warning restore LC0015

{
    Caption = 'Instructor Class Overview';
    PageType = Document;
    SourceTable = Instructor;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(Chart)
            {
                Caption = 'Chart';
                usercontrol(DateChart; GoogleDateChart)
                {
                    ApplicationArea = all;
                    trigger ControlReady()
                    begin
                        CurrPage.DateChart.createDateChart(CreateDataJsonArray());
                    end;

                    trigger CallBackBC(callback: Text)
                    begin
                        // message(callback);
                        SeminarRegistrationHeader.Reset();
                        TempInstructorLoad.Reset();
                        TempInstructorLoad.SetFilter("Allocation Date", callback);
                        TempInstructorLoad.SetFilter("Seminar Registration", '<>%1', '');
                        if TempInstructorLoad.FindSet() then
                            repeat
                                SeminarRegistrationHeader.Get(TempInstructorLoad."Seminar Registration");
                                SeminarRegistrationHeader.Mark(true);
                            until TempInstructorLoad.Next() = 0;
                        SeminarRegistrationHeader.MarkedOnly(true);
                        Page.RunModal(Page::"Seminar Registration List", SeminarRegistrationHeader);
                        SeminarRegistrationHeader.ClearMarks();
                        CurrPage.DateChart.createDateChart(CreateDataJsonArray());
                    end;
                }
            }
        }
    }
    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
        TempInstructorLoad: Record "Temp Instructor Load" temporary;

#pragma warning disable LC0010
    procedure CreateDataJsonArray(): JsonArray
#pragma warning restore LC0010
    var
        WorkingDate: Record Date;
        JArray: JsonArray;
        data: JsonArray;
        JsonObj: JsonObject;
        // WorkLoad: Decimal;
        n: Integer;
    begin
        Clear(JArray);
        JsonObj.Add('type', 'date');
        JsonObj.Add('id', 'Date');
        JArray.Add(JsonObj);
        Clear(JsonObj);
        JsonObj.Add('type', 'number');
        JsonObj.Add('id', 'Won/Loss');
        JArray.Add(JsonObj);
        data.Add(JArray);

        TempInstructorLoad.Reset();
        TempInstructorLoad.DeleteAll();

        SeminarRegistrationHeader.Reset();
        SeminarRegistrationHeader.SetCurrentKey("Instructor Code", "Starting Date");
        SeminarRegistrationHeader.SetFilter("Instructor Code", Rec.Code);
        SeminarRegistrationHeader.SetFilter("Starting Date", '%1..', Today());

        WorkingDate.Reset();
        WorkingDate.SetRange("Period Type", WorkingDate."Period Type"::Date);
        WorkingDate.SetRange("Period No.", 1, 5);
        WorkingDate.SetFilter("Period Start", '%1..%2', DMY2Date(1, 1, Date2DMY(Today(), 3)), DMY2Date(31, 12, Date2DMY(Today(), 3) + 1));

        if WorkingDate.FindSet() then
            repeat
                TempInstructorLoad.Init();
                TempInstructorLoad."Instructor Code" := Rec.Code;
                TempInstructorLoad."Seminar Registration" := '';
                TempInstructorLoad.Allocation := 0;
                TempInstructorLoad."Allocation Date" := WorkingDate."Period Start";
                TempInstructorLoad.Insert();
            until WorkingDate.Next() = 0;

        if SeminarRegistrationHeader.FindSet() then
            repeat
                WorkingDate.SetFilter("Period Start", '%1..', SeminarRegistrationHeader."Starting Date");
                WorkingDate.FindSet();
                for n := 1 to SeminarRegistrationHeader.Duration do begin
                    TempInstructorLoad.Init();
                    TempInstructorLoad."Instructor Code" := SeminarRegistrationHeader."Instructor Code";
                    TempInstructorLoad."Seminar Registration" := SeminarRegistrationHeader."No.";
                    TempInstructorLoad.Allocation := 1;
                    TempInstructorLoad."Allocation Date" := WorkingDate."Period Start";
                    TempInstructorLoad.Insert();
                    WorkingDate.Next();
                end;
            until SeminarRegistrationHeader.Next() = 0;

        if TempInstructorLoad.FindSet() then
            repeat
                TempInstructorLoad.SetRange("Seminar Registration");
                TempInstructorLoad.SetRange("Allocation Date", TempInstructorLoad."Allocation Date");
                TempInstructorLoad.CalcSums(Allocation);
                Clear(JArray);
                JArray.Add(formatDate(TempInstructorLoad."Allocation Date"));
                JArray.Add(TempInstructorLoad.Allocation);
                data.Add(JArray);

                TempInstructorLoad.SetRange("Seminar Registration", '');
                TempInstructorLoad.FindLast();
                TempInstructorLoad.SetRange("Allocation Date");
            until TempInstructorLoad.Next() = 0;
        exit(data);
    end;

    local procedure formatDate(Date2Format: Date): Text
    begin
        exit(Format(Date2Format, 0, 'Date(' + DelChr(Format(Date2DMY(Date2Format, 3)), '=', '.,') + ',' + Format((Date2DMY(Date2Format, 2) - 1)) + ',' + Format(Date2DMY(Date2Format, 1)) + ')'));
    end;
}