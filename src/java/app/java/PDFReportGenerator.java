package app.java;


import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

public class PDFReportGenerator {

    public static void generateMonthlyReport(List<AttendanceRecord> records, String month, String outputPath) {
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, new FileOutputStream(outputPath));
            document.open();

            // Add title
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Monthly Attendance Report - " + month, titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(Chunk.NEWLINE);

            // Create table
            PdfPTable table = new PdfPTable(4); // 4 columns
            table.setWidthPercentage(100);
            table.setWidths(new int[]{1, 3, 2, 2});

            // Add table headers
            addTableHeader(table);

            // Add rows to table
            for (AttendanceRecord record : records) {
                addTableRow(table, record);
            }

            document.add(table);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            document.close();
        }
    }

    private static void addTableHeader(PdfPTable table) {
        String[] headers = {"ID", "Student Name", "Date", "Status"};
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            table.addCell(cell);
        }
    }

    private static void addTableRow(PdfPTable table, AttendanceRecord record) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        table.addCell(String.valueOf(record.getId()));
        table.addCell(record.getStudentName());
        table.addCell(dateFormat.format(record.getDate()));
        table.addCell(record.getStatus());
    }
}