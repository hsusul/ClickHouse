-- Input that ends with a field delimiter (no final newline) must be parsed exactly like the same input with a final newline.
-- https://github.com/ClickHouse/ClickHouse/issues/91776
-- Each pair: the first query ends with the delimiter, the second one adds a newline.

SELECT 'TSV, variable number of columns, empty_as_default';
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 1;
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 1;

SELECT 'TSV, variable number of columns, no empty_as_default';
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 0;
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 0;

SELECT 'TSV, Nullable column';
SELECT * FROM format(TSV, 'c1 String, c2 Nullable(Int64), c3 String', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 1;
SELECT * FROM format(TSV, 'c1 String, c2 Nullable(Int64), c3 String', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1, input_format_tsv_empty_as_default = 1;

SELECT 'TSV, several missing columns';
SELECT * FROM format(TSV, 'c1 String, c2 UInt32, c3 String, c4 Int64', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSV, 'c1 String, c2 UInt32, c3 String, c4 Int64', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;

SELECT 'TSV, several rows';
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t1\tx\nb\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSV, 'c1 String, c2 Int64, c3 String', 'a\t1\tx\nb\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;

SELECT 'TSVWithNames';
SELECT * FROM format(TSVWithNames, 'c1 String, c2 Int64, c3 String', 'c1\tc2\tc3\na\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSVWithNames, 'c1 String, c2 Int64, c3 String', 'c1\tc2\tc3\na\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;

SELECT 'TSV, fixed number of columns, empty last field';
SELECT * FROM format(TSV, 'c1 String, c2 Int64', 'a\t') SETTINGS input_format_tsv_empty_as_default = 0;
SELECT * FROM format(TSV, 'c1 String, c2 Int64', 'a\t\n') SETTINGS input_format_tsv_empty_as_default = 0;

SELECT 'TSVRaw';
SELECT * FROM format(TSVRaw, 'c1 String, c2 Nullable(String), c3 Int64', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSVRaw, 'c1 String, c2 Nullable(String), c3 Int64', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSVRaw, 'c1 String, c2 Int64', 'a\t') SETTINGS input_format_tsv_empty_as_default = 1;
SELECT * FROM format(TSVRaw, 'c1 String, c2 Int64', 'a\t\n') SETTINGS input_format_tsv_empty_as_default = 1;

SELECT 'CSV, variable number of columns, empty_as_default';
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;

SELECT 'CSV, variable number of columns, no empty_as_default';
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 0;
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 0;

SELECT 'CSV, Nullable column';
SELECT * FROM format(CSV, 'c1 String, c2 Nullable(Int64), c3 String', 'a,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSV, 'c1 String, c2 Nullable(Int64), c3 String', 'a,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;

SELECT 'CSV, several missing columns';
SELECT * FROM format(CSV, 'c1 String, c2 UInt32, c3 String, c4 Int64', 'a,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSV, 'c1 String, c2 UInt32, c3 String, c4 Int64', 'a,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;

SELECT 'CSV, whitespace after the delimiter';
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a, ') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSV, 'c1 String, c2 Int64, c3 String', 'a, \n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;

SELECT 'CSVWithNames';
SELECT * FROM format(CSVWithNames, 'c1 String, c2 Int64, c3 String', 'c1,c2,c3\na,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSVWithNames, 'c1 String, c2 Int64, c3 String', 'c1,c2,c3\na,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;

SELECT 'CSV, fixed number of columns, empty last field';
SELECT * FROM format(CSV, 'c1 String, c2 Int64', 'a,') SETTINGS input_format_csv_empty_as_default = 0;
SELECT * FROM format(CSV, 'c1 String, c2 Int64', 'a,\n') SETTINGS input_format_csv_empty_as_default = 0;

SELECT 'String columns only, already worked';
SELECT * FROM format(TSV, 'c1 String, c2 String, c3 String', 'a\t') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(TSV, 'c1 String, c2 String, c3 String', 'a\t\n') SETTINGS input_format_tsv_allow_variable_number_of_columns = 1;
SELECT * FROM format(CSV, 'c1 String, c2 String, c3 String', 'a,') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
SELECT * FROM format(CSV, 'c1 String, c2 String, c3 String', 'a,\n') SETTINGS input_format_csv_allow_variable_number_of_columns = 1, input_format_csv_empty_as_default = 1;
