const pay = () => {
  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  numberElement.mount("#number-form");
  const expiryElement = elements.create("cardExpiry");
  expiryElement.mount("#expiry-form");
  const cvcElement = elements.create("cardCvc");
  cvcElement.mount("#cvc-form");
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then((response) => {
      const token = response.id;
      const renderDom = document.createElement("input");
      renderDom.setAttribute("name", "token");
      renderDom.setAttribute("value", token);
      form.appendChild(renderDom);
      form.submit();
      });
    });
};

window.addEventListener("load", pay);