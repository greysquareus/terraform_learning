/*
check "name" {
  data "http" "check_site" {
    url = "https://googleewew.com"
  }

  assert {
    condition = data.http.check_site.status_code == 200
    error_message = "Site don`t work"
  }
}
*/
/*
check "check_budget_exceeded" {
  data "aws_budgets_budget" "example" {
    name = aws_budgets_budget.example.name
  }

  assert {
    error_message = "Budget is exceede"
    condition =  !data.aws_budgets_budget.example.check_budget_exceeded
  }

}
*/
