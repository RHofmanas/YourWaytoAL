#pragma warning disable LC0015
codeunit 50004 "Seminar Registration-Printed"
#pragma warning restore LC0015
{
    TableNo = "Seminar Registration Header";
    Permissions = tabledata "Seminar Registration Header" = RM;

    trigger OnRun()
    var
        SeminarRegHeader: Record "Seminar Registration Header";
    begin
        SeminarRegHeader.FindFirst();
        repeat
            SeminarRegHeader."No. Printed" := SeminarRegHeader."No. Printed" + 1;
        until SeminarRegHeader.Next() = 0;
#pragma warning disable LC0002
        Commit();
#pragma warning restore LC0002
    end;

    procedure SetSuppressCommit(var NewSuppressCommit: Boolean)
    begin
        SuppressCommit := NewSuppressCommit;
    end;

    var
        SuppressCommit: Boolean;

    [IntegrationEvent(false, false)]
    procedure OnBeforeRun(SuppressCommit: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeModify(SuppressCommit: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterRun(SuppressCommit: Boolean)
    begin
    end;
}

