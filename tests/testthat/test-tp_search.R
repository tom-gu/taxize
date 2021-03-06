# tests for tp_search fxn in taxize
context("tp_search")


test_that("tp_search returns the correct class", {
  skip_on_cran()

  ttt <- suppressMessages(tp_search(name = 'Poa annua'))
  uuu <- suppressMessages(tp_search(name = 'stuff things'))

  if ("error" %in% names(ttt)) skip("error in tp_search call - skipping")
  if ("error" %in% names(uuu)) skip("error in tp_search call - skipping")

	expect_that(ttt, is_a("data.frame"))

  expect_that(uuu, is_a("data.frame"))
  expect_that(names(uuu), equals("error"))
  expect_that(as.character(uuu[1,1]), equals("No names were found"))
})

test_that("tp_search behaves correctly on dot inputs", {
  skip_on_cran()

  expect_that(tp_search('Poa annua .annua'),
              gives_warning("detected, being URL encoded"))
  expect_warning(tp_search('Poa annua annua'), NA)
})

test_that("tp_search behaves correctly on subspecific inputs", {
  skip_on_cran()

  expect_that(tp_search('Poa annua var annua'),
              gives_warning("Tropicos doesn't like"))
  expect_that(tp_search('Poa annua var. annua'),
              gives_warning("Tropicos doesn't like"))
  expect_that(tp_search('Poa annua sp. annua'),
              gives_warning("Tropicos doesn't like"))
  expect_that(tp_search('Poa annua ssp. annua'),
              gives_warning("Tropicos doesn't like"))
  expect_that(tp_search('Poa annua subspecies annua'),
              gives_warning("Tropicos doesn't like"))

  expect_warning(tp_search('Poa annua foo bar annua'), NA)
})
