# PIZZARIA - 

# Lista de Pizzas e Preços
$Pizza = @("Calabresa", "Pepperoni", "Frango com catupiry", "Portuguesa", "Muçarela", "Brócolis", "4 Queijos", "Moda da Casa", "Brigadeiro", "Doce de leite")
$PreçodasPizzas = @(25, 30, 28, 27, 22, 24, 35, 40, 18, 20)

# Loop para garantir que o pedido será repetido até que o usuário faça uma escolha correta
$pedidoValido = $false  # Inicializa a variável para controle do loop
do {
    # Mostrar opções de sabores
    Write-Host "Escolha um sabor de pizza:`n" # Usamos o `n para pular linhas na hora de exibir o código para ficar mais bonito
    for ($i = 0; $i -lt $Pizza.Length; $i++) {
        Write-Host "$($i + 1) - $($Pizza[$i])"
    }

    # Escolher o sabor da pizza
    $escolha = Read-Host "Digite o número do sabor desejado"

    # Verificar se a entrada é um número
    if ($escolha -match '^\d+$') {
        $escolha = [int]$escolha  # Converte para inteiro

        # Verificar se a escolha está dentro do intervalo válido
        if ($escolha -ge 1 -and $escolha -le $Pizza.Length) {
            $saborEscolhido = $Pizza[$escolha - 1]
            $precoEscolhido = $PreçodasPizzas[$escolha - 1]
            Write-Host "`nVocê escolheu o sabor: $saborEscolhido"
            Write-Host "O preço dessa pizza é: R$ $precoEscolhido"

            # Inicializa o valor total da compra com o preço da pizza escolhida
            $PrecoTotal = $precoEscolhido  # Inicializando a variável que vai somar o preço total

            # Define uma lista (array) com os complementos disponíveis para compra
            $opcoes = @(
                "Coca",
                "Soda",
                "Guaraná",
                "Batata",
                "Mini churros",
                "Mini pastel"
            )

            # Preço de cada adicional
            $PrecosAdicionais = @(5, 3, 2, 7, 9, 13)

            # Exibe a lista numerada de complementos disponíveis
            Write-Host "`nLista de complementos disponíveis:"
            for ($i = 0; $i -lt $opcoes.Count; $i++) {
                Write-Host "$($i + 1). $($opcoes[$i]) - R$ $($PrecosAdicionais[$i])"
            }

            # Cria uma lista vazia para armazenar os itens escolhidos pelo usuário
            $escolhidos = @()

            # Inicia um loop para permitir que o usuário escolha vários itens e finalizar pressionando enter novamente
            do {
                $selecionado = Read-Host "`nDigite o número do complemento desejado (pressione Enter para finalizar)"

                if ($selecionado -match '^\d+$') {
                    $index = [int]$selecionado - 1
                    if ($index -ge 0 -and $index -lt $opcoes.Count) {
                        $escolhidos += $opcoes[$index]
                        $PrecoTotal += $PrecosAdicionais[$index]  # Soma o preço do adicional
                        Write-Host "Adicionado: $($opcoes[$index]) - R$ $($PrecosAdicionais[$index])"
                    } else {
                        Write-Host "Opção inválida." -ForegroundColor Red
                    }
                } elseif ($selecionado -ne "") {
                    Write-Host "Entrada inválida. Digite apenas o número do item ou pressione Enter para sair." -ForegroundColor Red
                }

            } while ($selecionado -ne "") 

            # Exibe os dados coletados
            Write-Host "`nPizza escolhida: $saborEscolhido"
            Write-Host "Complementos escolhidos: $escolhidos"

            # Verificar se o pedido está correto (confirmação do usuário)
            $confirmacao = Read-Host "`nVocê confirma que o pedido está correto? Digite (S/N)"
            if ($confirmacao -match '^[Ss]$') {
                Write-Host "`nPedido confirmado! A pizza será preparada e os acompanhamentos também!" -ForegroundColor Green
                $pedidoValido = $true  # Finaliza o loop, já que o pedido foi confirmado
            } elseif ($confirmacao -match '^[Nn]$') {
                Write-Host "`nPedido cancelado. Por favor, refaça a escolha." -ForegroundColor Red
                $pedidoValido = $false  # Continua o loop, pois o pedido foi cancelado
            } else {
                Write-Host "`nOpção inválida. Tente novamente." -ForegroundColor Red
                $pedidoValido = $false  # Continua o loop se a confirmação for inválida
            }
        } else {
            Write-Host "`nEscolha inválida! O número deve estar entre 1 e $($Pizza.Length)." -ForegroundColor Red
            $pedidoValido = $false  # Continua o loop, pois a escolha estava fora do intervalo
        }
    } else {
        Write-Host "`nPor favor, digite um número válido!" -ForegroundColor Red
        $pedidoValido = $false  # Continua o loop, pois a entrada não era um número
    }

} while (-not $pedidoValido) # O loop vai continuar até o pedido ser válido (confirmado pelo usuário)

# Agora solicita o endereço do usuário
$endereco = Read-Host "`nOK, agora para a entrega. Por favor, informe o seu endereço"

# Exibe os dados coletados
Write-Host "`nResumo do pedido:"
Write-Host "Pizza: $saborEscolhido - R$ $precoEscolhido"
if ($escolhidos.Count -gt 0) {
    Write-Host "Complementos escolhidos:"
    $escolhidos | ForEach-Object { Write-Host "- $_" }
} else {
    Write-Host "Nenhum complemento escolhido."
}
Write-Host "Endereço de entrega: $endereco"
Write-Host "`nValor total do pedido: R$ $PrecoTotal" -ForegroundColor Green

# Solicitar a forma de pagamento
$pagamentoValido = $false
do {
    # Mostrar opções de pagamento
    Write-Host "`nEscolha a forma de pagamento:"
    Write-Host "1 - Dinheiro"
    Write-Host "2 - Cartão de crédito"
    Write-Host "3 - Pix"
    
    $formaPagamento = Read-Host "Digite o número da forma de pagamento desejada"

    # Verificar se a entrada é um número e se está dentro do intervalo de opções válidas
    if ($formaPagamento -match '^\d+$') {
        $formaPagamento = [int]$formaPagamento

        if ($formaPagamento -eq 1) {
            Write-Host "`nVocê escolheu pagar com Dinheiro."
            $pagamentoValido = $true
        } elseif ($formaPagamento -eq 2) {
            Write-Host "`nVocê escolheu pagar com Cartão de crédito."
            $pagamentoValido = $true
        } elseif ($formaPagamento -eq 3) {
            Write-Host "`nVocê escolheu pagar com Pix."
            $pagamentoValido = $true
        } else {
            Write-Host "`nOpção inválida. Tente novamente." -ForegroundColor Red
        }
    } else {
        Write-Host "`nPor favor, digite um número válido para a forma de pagamento!" -ForegroundColor Red
    }
} while (-not $pagamentoValido) # O loop vai continuar até o pagamento ser validado

Write-Host "`nResumo final do pedido:"
Write-Host "Pizza: $saborEscolhido - R$ $precoEscolhido"
if ($escolhidos.Count -gt 0) {
    Write-Host "Complementos escolhidos:"
    $escolhidos | ForEach-Object { Write-Host "- $_" }
} else {
    Write-Host "Nenhum complemento escolhido."
}
Write-Host "Endereço de entrega: $endereco"
Write-Host "`nValor total do pedido: R$ $PrecoTotal" -ForegroundColor Green
Write-Host "`nForma de pagamento escolhida:"

switch ($formaPagamento) {
    1 { Write-Host "Dinheiro" }
    2 { Write-Host "Cartão de crédito" }
    3 { Write-Host "Pix" }
}
 
 # Comentario feliz para esperar
Write-Host "Segura a fome que a comida ta chegando! :)" -ForegroundColor Yellow
