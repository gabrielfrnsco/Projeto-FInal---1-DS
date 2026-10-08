// Este arquivo roda no NAVEGADOR.
// Ele não fala com o Neon: chama as rotas /api do nosso server.js.

const lista = document.getElementById('lista-categorias')
const formulario = document.getElementById('form-categoria')
const campoDescricao = document.getElementById('descricao')
const mensagem = document.getElementById('mensagem')

async function carregarCategorias() {
    lista.innerHTML = '<li>Carregando...</li>'
    try {
        const resposta = await fetch('/api/categorias')
        const categorias = await resposta.json()
        if (!resposta.ok) throw new Error(categorias.erro)

        lista.innerHTML = ''
        for (const categoria of categorias) {
            const item = document.createElement('li')
            item.textContent = `#${categoria.id_categoria} - ${categoria.descricao}`
            lista.appendChild(item)
        }
        if (categorias.length === 0) lista.innerHTML = '<li>Nenhuma categoria cadastrada.</li>'
    } catch (erro) {
        lista.innerHTML = `<li>Erro: ${erro.message}</li>`
    }
}

formulario.addEventListener('submit', async (evento) => {
    evento.preventDefault()
    const resposta = await fetch('/api/categorias', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ descricao: campoDescricao.value })
    })
    const dados = await resposta.json()

    if (resposta.ok) {
        mensagem.textContent = `Categoria "${dados.descricao}" cadastrada!`
        campoDescricao.value = ''
        carregarCategorias()
    } else {
        mensagem.textContent = `Erro: ${dados.erro}`
    }
})

carregarCategorias()
