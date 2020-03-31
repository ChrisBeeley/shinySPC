
context("File load")

test_that("Wrong file extension returns message", {
  expect_equal(clean_data("test.csv2"), "This file type is not supported")
  expect_equal(clean_data("testcsv"), "This file type is not supported")
  expect_equal(clean_data(""), "This file type is not supported")
  expect_error(clean_data(NULL), "argument is of length zero")
})

test_that("Right file extension returns dataframe", {
  expect_true(is.data.frame(clean_data("test_files/upload_example_simple.csv")))
  expect_true(is.data.frame(clean_data("test_files/WeeklyTablesRevised12.xls")))
  expect_true(is.data.frame(clean_data("test_files/arrival_time_tsv.tsv")))
  expect_true(is.data.frame(clean_data("test_files/arrival_time_tsv.tab")))
  expect_true(is.data.frame(clean_data("test_files/upload_example.xlsx")))
})

test_that("Row skipping works", {
  expect_true("Type 1 Departments - Major A&E" %in% 
                names(clean_data("test_files/Timeseries-monthly.xls", skip = 17)))
  expect_true("Date" %in% 
                names(clean_data("test_files/arrival_time.csv", skip = 0)))
})

test_that("col_names works", {
  expect_equal(clean_data("test_files/upload_example_no_header.csv", col_names = FALSE)[[1, 1]], 1)
  # specifying three names when 5 exist throws a warning
  expect_warning(out <- ncol(clean_data("test_files/upload_example.csv", skip = 1, 
                                   col_names = c("Gap time", "Time", "Date"))))
  # specifying three names when 5 exist returns three names, not five
  expect_equal(out, 3)
})