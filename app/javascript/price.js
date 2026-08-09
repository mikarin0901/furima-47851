const calculatePrice = () => {
  const priceInput = document.getElementById("item-price")

  if (!priceInput) return

  const taxPrice = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value)

    if (priceInput.value === "" || !Number.isFinite(price)) {
      taxPrice.innerHTML = ""
      profit.innerHTML = ""
      return
    }

    const fee = Math.floor(price * 0.1)
    const salesProfit = price - fee

    taxPrice.innerHTML = fee
    profit.innerHTML = salesProfit
  })
}

document.addEventListener("turbo:load", calculatePrice)