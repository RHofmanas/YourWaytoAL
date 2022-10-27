#pragma warning disable LC0015
codeunit 50003 "Navigate Triger Extension"
#pragma warning restore LC0015
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure FindRecordsOnAfterNavigate(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        FindPstdSeminarRegHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
        FindSeminarRegHeader(DocumentEntry, DocNoFilter, PostingDateFilter);
        FindSeminarLedgerEntries(DocumentEntry, DocNoFilter, PostingDateFilter);
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ShowRecordsOnAfterNavigate(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary)

    begin
        case TempDocumentEntry."Table ID" of
            Database::"Seminar Registration Header":
                begin
                    SeminarRegHeader.Reset();
                    SeminarRegHeader.SetCurrentKey("No.", "Posting Date");
                    SeminarRegHeader.SetFilter("No.", DocNoFilter);
                    SeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Seminar Registration", SeminarRegHeader)
                    else
                        Page.Run(0, SeminarRegHeader);
                end;
            Database::"Posted Seminar Reg. Header":
                begin
                    PstdSeminarRegHeader.Reset();
                    PstdSeminarRegHeader.SetCurrentKey("No.", "Posting Date");
                    PstdSeminarRegHeader.SetFilter("No.", DocNoFilter);
                    PstdSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);

                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Posted Seminar Registration", PstdSeminarRegHeader)
                    else
                        Page.Run(0, PstdSeminarRegHeader);
                end;
            Database::"Seminar Ledger Entry":
                begin
                    SeminarLedgEntry.Reset();
                    SeminarLedgEntry.SetCurrentKey("Document No.", "Posting Date");
                    SeminarLedgEntry.SetFilter("Document No.", DocNoFilter);
                    SeminarLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                    if TempDocumentEntry."No. of Records" = 1 then
                        Page.Run(Page::"Seminar Ledger Entries", SeminarLedgEntry)
                    else
                        Page.Run(0, SeminarLedgEntry);
                end;
        end;
    end;

    local procedure FindSeminarLedgerEntries(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if SeminarLedgEntry.ReadPermission() then begin
            SeminarLedgEntry.Reset();
            SeminarLedgEntry.SetCurrentKey("Document No.");
            SeminarLedgEntry.SetFilter("Document No.", DocNoFilter);
            SeminarLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Value Entry",
            SeminarLedgEntry.TableCaption, SeminarLedgEntry.Count);
        end;
    end;

    local procedure FindPstdSeminarRegHeader(var DocumentEntry: Record "Document Entry";
        DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if PstdSeminarRegHeader.ReadPermission() then begin
            PstdSeminarRegHeader.Reset();
            PstdSeminarRegHeader.SetFilter("No.", DocNoFilter);
            PstdSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Posted Seminar Reg. Header",
            PstdSeminarRegHeader.TableCaption, // <----PstdSeminarRegHeader.TableCaption from PstdSeminarRegHeaderTxt
            PstdSeminarRegHeader.Count);
        end;
    end;

    local procedure FindSeminarRegHeader(var DocumentEntry: Record "Document Entry";
        DocNoFilter: Text; PostingDateFilter: Text)
    begin
        if SeminarRegHeader.ReadPermission() then begin
            SeminarRegHeader.Reset();
            SeminarRegHeader.SetFilter("No.", DocNoFilter);
            SeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(DocumentEntry, Database::"Seminar Registration Header",
            SeminarRegHeader.TableCaption, // <----SeminarRegHeader.TableCaption from SeminarRegHeaderTxt
            SeminarRegHeader.Count);   // <----SeminarRegHeader.Count from PstdSeminarRegHeader.Count
        end;
    end;

    local procedure InsertIntoDocEntry(var DocumentEntry: Record "Document Entry"; DocTableID: Integer; DocTableName: Text; DocNoOfRecords: Integer)
    begin
        if DocNoOfRecords = 0 then
            exit;

        DocumentEntry.Init();
        DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
        DocumentEntry."Table ID" := DocTableID;
        DocumentEntry."Document Type" := DocumentEntry."Document Type"::" ";
        DocumentEntry."Table Name" := CopyStr(DocTableName, 1, MaxStrLen(DocumentEntry."Table Name"));
        DocumentEntry."No. of Records" := DocNoOfRecords;
        DocumentEntry.Insert();
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        PstdSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgEntry: Record "Seminar Ledger Entry";
}
