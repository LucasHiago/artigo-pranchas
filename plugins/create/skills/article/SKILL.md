---
name: article
description: (/create:article) Gera post técnico no formato texto + carrossel de pranchas: `artigo.html` (texto pronto para colar no LinkedIn/Medium/blog, com o mapa das imagens) e `sessoes.html` (pranchas 1200×675 em HTML/SVG com design system próprio), exportadas para PNG por `export.sh` com trava de texto estourado. Use quando o usuário pedir artigo, post, carrossel, pranchas, cards ou "imagens para o post" sobre um tema técnico, ou quando quiser transformar uma ideia, um repositório ou um dado em post ilustrado.
---

# /create:article

Post = **um argumento em duas mídias**. Cada seção do texto tem uma prancha, na mesma
ordem. Quem só vê o carrossel entende; quem só lê o texto também.

Saída, numa pasta `artigo-<slug>/`:

```
artigo-<slug>/
  artigo.html     texto do post + src-map das imagens (o bloco do mapa não é publicado)
  sessoes.html    todas as pranchas numa folha; ?solo=NN isola uma
  export.sh       gera img/card-NN.png (2400×1350) e falha se alguma prancha estourar
  img/card-NN.png
```

Arquivos da skill (caminhos relativos a este SKILL.md):

- `templates/sessoes.html`: post completo de 16 pranchas. É o design system **e** o catálogo.
- `templates/artigo.html`: esqueleto do texto.
- `templates/export.sh`: exportador com trava de estouro.
- `references/layouts.md`: qual prancha usar para qual formato de ideia, e como trocar a marca.
- `references/texto.md`: estrutura e estilo do texto.

## Passos

Siga na ordem. Cada passo deixa um artefato.

### 1. Entrada

Pedido do usuário: $ARGUMENTS

Precisa de: tema, tese em uma frase, público, e **dados reais** disponíveis (repo, log,
planilha). Se o tema vier de um repositório local, leia o repositório e tire os números
dele (`git log`, contagem de arquivos, métricas). Número inventado não entra.

Marca, configurada na instalação do plugin:

- URL da empresa: `${user_config.company_url}`
- Série: `${user_config.series}`

Se a URL acima aparecer vazia ou como placeholder não substituído, pergunte em uma
linha e diga como gravar para as próximas vezes: `/plugin configure create@artigo-pranchas`.
No rodapé, mostre a URL sem `https://`, `www.` e barra final (`suaempresa.com.br`).
Série vazia: use o título curto do post. Cores: mantenha as do template salvo pedido.

### 2. Roteiro

Antes de qualquer HTML, escreva no chat a tabela do roteiro e siga sem esperar aprovação,
a menos que a tese esteja ambígua:

| # | afirmação da prancha (vira `h2`) | layout (`references/layouts.md`) | dado/exemplo concreto |
|---|---|---|---|

Regras:
- 10 a 16 pranchas. 01 é capa, a última é checklist ou síntese acionável.
- Uma ideia por prancha. Se precisa de "e" no título, são duas.
- `h2` é afirmação ("Prompt pede. Hook obriga."), não rótulo ("Hooks").
- Escolha layout pelo **formato da ideia** (sequência, contraste, camadas, rede, dado), não pelo tema.
  Não repita o mesmo layout em pranchas seguidas.
- Pelo menos uma prancha com dado real e fonte no rodapé (`data-src="fonte: ..."`).

### 3. Pasta

```bash
mkdir -p artigo-<slug>
cp <skill>/templates/{sessoes.html,artigo.html,export.sh} artigo-<slug>/
chmod +x artigo-<slug>/export.sh
```

### 4. `sessoes.html`

1. `<title>` e `const POST = { serie, site }`, com a série e a URL do passo 1.
2. Para cada linha do roteiro, parta do bloco `<!-- NN · ... -->` do layout escolhido.
   Reescreva o conteúdo e renumere `data-card` e a `.tag` em sequência (`01`, `02`, ...).
   Se o layout tem IIFE no `<script>`, troque só os dados dela (arrays no topo da função).
3. Apague os blocos de layouts não usados e as IIFEs deles. IIFE órfã não quebra nada,
   mas é código morto que confunde a próxima edição.
4. Mantenha o CSS. Classe nova só se nenhum layout do catálogo serve, e então no `<style>`
   do próprio arquivo, seguindo as variáveis `:root`.

Diagrama tem que mostrar o mecanismo real (quem chama quem, o que bloqueia o quê), não
ícones decorativos. Texto em SVG com no mínimo 11 px.

### 5. Exportar e conferir

```bash
./artigo-<slug>/export.sh
```

- Saída `prancha(s) com estouro: NN` → encurte o texto ou reduza o diagrama da prancha NN
  e rode de novo. Não mexa na trava.
- Depois abra **cada** `img/card-NN.png` e olhe: texto sobreposto, seta apontando para o
  vazio, rótulo de SVG cortado na borda, contraste baixo. A trava pega estouro de caixa,
  não pega SVG desenhado errado.

### 6. `artigo.html`

Siga `references/texto.md`. Preencha o `.mapa` com uma `<li>` por prancha e, em cada seção,
o bloco `.img` com caminho **absoluto** `file://<pasta>/img/card-NN.png`.
Uma seção por prancha, na mesma ordem e com o mesmo argumento.

### 7. Entrega

Responda com os caminhos de `artigo.html`, `sessoes.html` e da pasta `img/`, a contagem de
pranchas e qualquer número que o usuário precisa confirmar antes de publicar.

## Não faça

- Inventar dado, depoimento ou métrica. Sem fonte, a prancha sai.
- Imagem gerada, foto de banco ou ícone decorativo no lugar de diagrama.
- Mais de 4 palavras em `.hl` num título.
- Publicar o bloco `.mapa`; ele é só para o autor.
