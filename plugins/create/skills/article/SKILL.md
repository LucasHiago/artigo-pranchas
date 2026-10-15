---
name: article
description: (/create:article) Gera post técnico no formato texto + carrossel de pranchas: `artigo.html` (texto pronto para colar no LinkedIn/Medium/blog, com o mapa das imagens) e `sessoes.html` (pranchas 1200×675 em HTML/SVG, com direção visual própria por post: capa, paleta, fontes e moldura que não repetem as dos posts anteriores), exportadas para PNG por `export.sh` com trava de texto estourado. Parte de tema e descrição curta, escreve o rascunho seção por seção com a ideia de cada imagem e só gera as pranchas depois da aprovação. Use quando o usuário pedir artigo, post, carrossel, pranchas, cards ou "imagens para o post" sobre um tema técnico, ou quando quiser transformar uma ideia, um repositório ou um dado em post ilustrado.
---

# /create:article

Post = **um argumento em duas mídias**. Cada seção do texto tem uma prancha, na mesma
ordem. Quem só vê o carrossel entende; quem só lê o texto também.

Saída, numa pasta `artigo-<slug>/`:

```
artigo-<slug>/
  direcao.md      direção visual deste post (capa, paleta, fontes, moldura), aprovada junto
  rascunho.md     texto + ideia de cada imagem, aprovado pela pessoa antes de tudo
  artigo.html     texto do post + src-map das imagens (o bloco do mapa não é publicado)
  sessoes.html    todas as pranchas numa folha; ?solo=NN isola uma
  export.sh       gera img/card-NN.png (2400×1350) e falha se alguma prancha estourar
  img/card-NN.png
```

Arquivos da skill (caminhos relativos a este SKILL.md):

- `templates/sessoes.html`: post completo de 16 pranchas. É o design system mecânico **e** o
  catálogo; a aparência dele é só exemplo e não se repete (ver `references/direcao.md`).
- `templates/artigo.html`: esqueleto do texto.
- `templates/export.sh`: exportador com trava de estouro.
- `templates/pedido.md`: modelo de pedido em arquivo.
- `references/direcao.md`: direção visual por post (capa, paleta, fontes, moldura), memória
  dos posts anteriores e o resumo de taste/impeccable.
- `references/layouts.md`: qual prancha usar para qual formato de ideia.
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

**Pedido em arquivo.** Se `$ARGUMENTS` for o caminho de um `.md`, leia o arquivo; o modelo
está em `templates/pedido.md`:

- `# <tema>`: primeira linha, vira o `<slug>` da pasta.
- parágrafo abaixo: descrição (tese e público).
- `fonte: <caminhos>` (opcional): de onde tirar os números; caminho relativo ao `.md`.
- `NN: <descrição>`: uma linha por prancha que a pessoa quer controlar. Números que faltam
  são pranchas que a skill decide; o total de seções continua de 10 a 16.

Linha que não casa com esses formatos é contexto extra para o rascunho, não instrução.

Marca, configurada na instalação do plugin:

- URL da empresa: `${user_config.company_url}`

Se a URL acima aparecer vazia ou como placeholder não substituído, pergunte em uma
linha e diga como gravar para as próximas vezes: `/plugin configure create@artigo-pranchas`.
No rodapé, mostre a URL sem `https://`, `www.` e barra final (`suaempresa.com.br`).
À esquerda do rodapé vai o título curto **deste** post (3 a 4 palavras), não um nome fixo.
Cores, fontes e moldura **não** são as do template: saem da direção visual do passo 2.
O rodapé (título curto + URL) é a única assinatura fixa entre posts.

### 2. Direção visual, rascunho e aprovação

Crie `artigo-<slug>/`. Primeiro a **direção visual**, seguindo `references/direcao.md`:
carregue `taste-skill` e `impeccable` se estiverem disponíveis (só as partes que a
referência indica, sem os scripts do impeccable), leia o que os posts anteriores usaram e
escreva `artigo-<slug>/direcao.md`: mundo, arquétipo de capa, paleta, fontes, moldura,
gramática dos diagramas e o que não repete. Mostre no chat em poucas linhas, antes do texto.

Depois escreva o artigo inteiro em `artigo-<slug>/rascunho.md`, seguindo `references/texto.md`,
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
- Capa sempre `novo`, no arquétipo do `direcao.md`; nunca o bloco `01` do catálogo.
- Layout pelo **formato da ideia** (sequência, contraste, camadas, rede, dado), não pelo tema.
  Nenhum layout do catálogo mais de uma vez, e pelo menos 1/3 das seções (fora a capa)
  `novo`, desenhadas na gramática do mundo escolhido. O catálogo é ponto de partida: se
  encaixar o tema num layout deixa a imagem genérica, marque "novo".
- Fechamento no formato do mundo (ficha, comando, lista única); a checklist 3×2 é último recurso.
- Pelo menos uma seção com dado real e fonte.

Depois do rascunho, **pare e peça aprovação**, em uma linha: a pessoa responde `ok` para
aprovar tudo, ou aponta a seção e o ajuste (`03: troca o exemplo`, `07 imagem: mostra o
fluxo ao contrário`, `corta a 09`, `direção: fundo escuro`, `capa: tipográfica`). Ela também
pode editar `rascunho.md` ou `direcao.md` direto e avisar.

Aplique os ajustes, mostre de novo **só as seções que mudaram** e peça aprovação outra vez.
Repita até o `ok`. Renumere se cortar ou juntar seções. O rascunho e a direção aprovados
são o contrato dos passos seguintes: texto e imagem saem deles, sem mudar o argumento nem o mundo.

### 3. Pasta

```bash
cp <skill>/templates/{sessoes.html,artigo.html,export.sh} artigo-<slug>/
chmod +x artigo-<slug>/export.sh
```

### 4. `sessoes.html`

1. `<title>` e `const POST = { serie, site }`: `serie` é o título curto do post, `site` a URL do passo 1.
2. Aplique a direção **antes** das pranchas (`references/direcao.md`, seção 9): fontes no
   `<link>` e em `--display`/`--font`/`--mono`, cores no `:root`, `--frame`, hex literais dos
   SVGs trocados no arquivo todo. Com impeccable disponível, leia `reference/craft-floor.md` agora.
3. Para cada seção do rascunho, parta do bloco `<!-- NN · ... -->` do layout escolhido.
   Reescreva o conteúdo e renumere `data-card` e a `.tag` em sequência (`01`, `02`, ...).
   Se o layout tem IIFE no `<script>`, troque só os dados dela (arrays no topo da função).
   Bloco do catálogo reaproveitado é redesenhado na gramática do post, não só recolorido.
   A capa é escrita do zero (pode reusar o helper `el()` do `<script>`).
4. Apague os blocos de layouts não usados e as IIFEs deles. IIFE órfã não quebra nada,
   mas é código morto que confunde a próxima edição.
5. Mantenha as medidas do CSS (prancha, padding, rodapé, `.fill`). Moldura, raio, eyebrow e
   classes novas seguem o `direcao.md`, no `<style>` do próprio arquivo e usando as variáveis `:root`.

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
- Teste de irmãos: abra o `card-01.png` deste post ao lado do dos 3 posts anteriores. Se
  parecem a mesma série de template, refaça capa e moldura. Confira cada linha do `direcao.md`.

### 6. `artigo.html`

Passe o texto aprovado de `rascunho.md` para o HTML, sem reescrever. Preencha o `.mapa` com uma `<li>` por prancha e, em cada seção,
o bloco `.img` com caminho **absoluto** `file://<pasta>/img/card-NN.png`.
Uma seção por prancha, na mesma ordem e com o mesmo argumento.

### 7. Entrega

Responda com os caminhos de `artigo.html`, `sessoes.html`, `rascunho.md`, `direcao.md` e da pasta `img/`, a contagem de
pranchas e qualquer número que o usuário precisa confirmar antes de publicar.

## Não faça

- Gerar `sessoes.html`, PNG ou `artigo.html` antes do `ok` no rascunho e na direção.
- Reusar a capa do catálogo, a paleta roxa/Inter do template ou a direção de um post anterior.
- Inventar dado, depoimento ou métrica. Sem fonte, a prancha sai.
- Imagem gerada, foto de banco ou ícone decorativo no lugar de diagrama.
- Mais de 4 palavras em `.hl` num título.
- Publicar o bloco `.mapa`; ele é só para o autor.
