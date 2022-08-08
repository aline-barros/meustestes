*** Settings ***
Library     SeleniumLibrary

*** Variables ***

${url}                          https://www.amazon.com.br/
${Menu_Eletronicos}             //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${Header_Eletronicos}           //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***

Abrir o navegador
    Open Browser        browser=chrome
    Maximize Browser Window

Fechar o navegador      
    Capture Page Screenshot
    Close Browser
    

Acessar a home page do site Amazon.com.br
    Go To                               url=${url}
    Wait Until Element Is Visible       locator=${Menu_Eletronicos}

Entrar no menu "Eletrônicos"
    Click Element                       ${Menu_Eletronicos}

Verificar se aparece a frase "${frase}"
    Wait Until Page Contains            text=${frase}
    Wait Until Element Is Visible       locator=${Header_Eletronicos}

Verificar se o título da página fica "${Titulo}"
    Title Should Be         title=${Titulo}

Verificar se aparece a categoria "${Nome_Categoria}"
    Element Should Be Visible       locator=//a[contains(@aria-label,'${Nome_Categoria}')]

Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Input text      locator=twotabsearchtextbox     text=Xbox Series S

Clicar no botão de pesquisa
    Click Element       locator=nav-search-submit-text

Verificar o resultado da pesquisa, se está listando o produto "${Produto}"
    Wait Until Element Is Visible       locator=//img[contains(@alt,'${Produto}')]
    
#Gherkin Steps
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Tablets"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa, se está listando o produto "Console Xbox Series S"
