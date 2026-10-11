---
name: article
description: (/create:article) Gera post técnico no formato texto + carrossel de pranchas: `artigo.html` (texto pronto para colar no LinkedIn/Medium/blog, com o mapa das imagens) e `sessoes.html` (pranchas 1200×675 em HTML/SVG com design system próprio), exportadas para PNG por `export.sh` com trava de texto estourado. Parte de tema e descrição curta, escreve o rascunho seção por seção com a ideia de cada imagem e só gera as pranchas depois da aprovação. Use quando o usuário pedir artigo, post, carrossel, pranchas, cards ou "imagens para o post" sobre um tema técnico, ou quando quiser transformar uma ideia, um repositório ou um dado em post ilustrado.
---

# /create:article

Post = **um argumento em duas mídias**. Cada seção do texto tem uma prancha, na mesma
ordem. Quem só vê o carrossel entende; quem só lê o texto também.

Saída, numa pasta `artigo-<slug>/`:

```
artigo-<slug>/
  rascunho.md     texto + ideia de cada imagem, aprovado pela pessoa antes de tudo
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

Siga na ordem. Cada passo deixa um artefato. **Nenhum HTML antes da aprovação do passo 2.**

### 1. Entrada

Pedido do usuário: $ARGUMENTS

O mínimo é **tema e uma descrição curta** (o que a pessoa quer dizer, para quem). Disso a
skill tira a tese em uma frase e o público. Se o tema vier de um repositório local, leia o
repositório e tire os números dele (`git log`, contagem de arquivos, métricas). Número
inventado não entra. Pergunte em uma linha só se não der para tirar a tese do pedido.

**Descrições das pranchas (opcional).** O pedido pode trazer o que a pessoa quer ver em
cada imagem, numa linha por prancha, ou o caminho de um arquivo `.md` com essas linhas:

```
/create:article migração de banco sem downtime
01: capa com o banco no centro e as réplicas em volta
04: linha do tempo da migração, com o momento em que o tráfego troca de banco
09: gráfico de latência antes e depois, dados em metricas.csv
```

Quando houver descrição, ela manda: define o que a prancha mostra, e a skill só decide o
layout e o texto. Prancha sem descrição a skill propõe no passo 2.

Marca, configurada na instalação do plugin:

- URL da empresa: `${user_config.company_url}`

Se a URL acima aparecer vazia ou como placeholder não substituído, pergunte em uma
linha e diga como gravar para as próximas vezes: `/plugin configure create@artigo-pranchas`.
No rodapé, mostre a URL sem `https://`, `www.` e barra final (`suaempresa.com.br`).
À esquerda do rodapé vai o título curto **deste** post (3 a 4 palavras), não um nome fixo.
Cores: mantenha as do template salvo pedido.

### 2. Rascunho e aprovação

Crie `artigo-<slug>/` e escreva o artigo inteiro em `artigo-<slug>/rascunho.md`, seguindo `references/texto.md`,
e mostre no chat. Cada seção traz o texto **e** a ideia da imagem que vai com ele:

```markdown
# <título do post>

## 01 · capa
<abertura, 4 a 6 frases>
> **imagem:** <o que a prancha mostra, em uma frase: o mecanismo, não o enfeite>
> **layout:** <bloco do catálogo, ou "novo">  **dado:** <número e fonte, ou "—">

## 02 · <afirmação que vira o h2>
<parágrafo de 70 a 120 palavras>
> **imagem:** ...
> **layout:** ...  **dado:** ...
```

Regras do rascunho:
- 10 a 16 seções. 01 é capa, a última é checklist ou síntese acionável.
- Uma ideia por seção. Se o `h2` precisa de "e", são duas.
- `h2` é afirmação ("Prompt pede. Hook obriga."), não rótulo ("Hooks").
- "Imagem" é o mecanismo do tema em uma frase (quem chama quem, o que bloqueia o quê, o que
  mudou entre antes e depois). Com descrição da pessoa, é a descrição dela.
- Layout pelo **formato da ideia** (sequência, contraste, camadas, rede, dado), não pelo tema,
  e sem repetir o mesmo em seções seguidas. O catálogo é ponto de partida: se encaixar o
  tema num layout deixa a imagem genérica, marque "novo" e desenhe o SVG do mecanismo real.
- Pelo menos uma seção com dado real e fonte.

Depois do rascunho, **pare e peça aprovação**, em uma linha: a pessoa responde `ok` para
aprovar tudo, ou aponta a seção e o ajuste (`03: troca o exemplo`, `07 imagem: mostra o
fluxo ao contrário`, `corta a 09`). Ela também pode editar `rascunho.md` direto e avisar.

Aplique os ajustes, mostre de novo **só as seções que mudaram** e peça aprovação outra vez.
Repita até o `ok`. Renumere se cortar ou juntar seções. O rascunho aprovado é o contrato
dos passos seguintes: texto e imagem saem dele, sem mudar o argumento.

### 3. Pasta

```bash
cp <skill>/templates/{sessoes.html,artigo.html,export.sh} artigo-<slug>/
chmod +x artigo-<slug>/export.sh
```

### 4. `sessoes.html`

1. `<title>` e `const POST = { serie, site }`: `serie` é o título curto do post, `site` a URL do passo 1.
2. Para cada seção do rascunho, parta do bloco `<!-- NN · ... -->` do layout escolhido.
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
- Teste de tema: tape o título e pergunte se a imagem sozinha diz de que assunto é o post.
  Se servia igual para outro tema, redesenhe. Confira se a imagem mostra o que a linha
  "imagem" aprovada no rascunho pediu.

### 6. `artigo.html`

Passe o texto aprovado de `rascunho.md` para o HTML, sem reescrever. Preencha o `.mapa` com uma `<li>` por prancha e, em cada seção,
o bloco `.img` com caminho **absoluto** `file://<pasta>/img/card-NN.png`.
Uma seção por prancha, na mesma ordem e com o mesmo argumento.

### 7. Entrega

Responda com os caminhos de `artigo.html`, `sessoes.html`, `rascunho.md` e da pasta `img/`, a contagem de
pranchas e qualquer número que o usuário precisa confirmar antes de publicar.

## Não faça

- Gerar `sessoes.html`, PNG ou `artigo.html` antes do `ok` no rascunho.
- Inventar dado, depoimento ou métrica. Sem fonte, a prancha sai.
- Imagem gerada, foto de banco ou ícone decorativo no lugar de diagrama.
- Mais de 4 palavras em `.hl` num título.
- Publicar o bloco `.mapa`; ele é só para o autor.
