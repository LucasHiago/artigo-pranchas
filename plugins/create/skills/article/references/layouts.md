# Catálogo de layouts

`templates/sessoes.html` é um post completo de 16 pranchas, e cada prancha é um
layout reaproveitável **na mecânica**: a aparência (roxo, Inter, faixa, eyebrow) é do
post de exemplo e é trocada pela direção de cada post (`references/direcao.md`).
Nenhum layout entra mais de uma vez num post, e o reaproveitado é redesenhado na
gramática do post, não só recolorido. Escolha pelo **formato da ideia**, não pelo tema. Copie o
bloco `<!-- NN · ... -->` inteiro e, se houver, a IIFE `// NN · ...` do `<script>`
que desenha o SVG dela.

| # | layout | serve para | peças |
|---|---|---|---|
| 01 | rede radial (exemplo de capa) | **não é capa**: a capa é sempre nova (`direcao.md` §4). Serve no miolo para um centro e o que gira em volta | `h1` com `.hl`, `.sub`, IIFE `capa` (anel de nós, `ring = [[rótulo, cor], ...]`) |
| 02 | dois painéis lado a lado (SVG) | antes × depois, caos × ordem, sem X × com X | SVG estático, dois `rect` 520 de largura |
| 03 | círculos concêntricos + tabela | camadas, do núcleo para fora | SVG estático + `table` de 2 colunas |
| 04 | código + tiles numéricos | mostrar um arquivo real e os números que ele gera | `.grid2` → `.code` + `.tiles` (`.tile`, `.tile.g`) + `.note` |
| 05 | linha do tempo horizontal | eventos em ordem, com prompt × automação embaixo | IIFE `hk` (`ev = [[nome, ação, detalhe, destaque], ...]`) |
| 06 | pipeline numerado 4×2 | receita em passos, cada um com artefato | `.pipe` → `.st` (`b` número, `h3`, `code`, `p`); `.st.g` no último |
| 07 | grafo de papéis | quem passa o quê para quem; papel, limite, modelo | IIFE `agents` (`[x, y, nome, selo, [faz], não-faz]`) + setas estáticas |
| 08 | grafo de rastreabilidade | cadeia de artefatos com fan-out e fan-in | IIFE `trace` (`N` nós, `E` arestas) |
| 09 | dois códigos, ruim × bom | errado × certo no mesmo trecho | `.grid2` → dois `.code` com `.code__badge` `badge-red`/`badge-green`, `.mark-bad`/`.mark-good` |
| 10 | árvore + tabela de formatos | convenções, estrutura de pastas | `.code` com `pre.sm` + `table` com `td.mono` |
| 11 | números grandes + gráfico de barras | **dado real** com fonte | `.big` → `.stat`/`.stat.g` + IIFE `chart` (`D = [[mês, ano, total, destaque], ...]`, `cut` marca o antes/depois) |
| 12 | hub radial | um centro que responde várias perguntas | IIFE `hub` (`F = [[rótulo, pergunta, cor, x, y], ...]`, 3 à esquerda e 3 à direita) |
| 13 | queijo suíço | camadas que barram falhas diferentes | IIFE `cheese` (`L` camadas, `errs` falhas, uma por camada) |
| 14 | loop de passos com retorno | processo com um passo que costuma ser pulado | IIFE `loop` (`S = [[passo, comando], ...]`), seta tracejada de volta |
| 15 | matriz 2×2 | dois eixos, quatro quadrantes, um movimento | SVG estático; mova os `circle` e a seta |
| 16 | checklist 3×2 | fechamento, **último recurso**: prefira o formato do mundo do post (`direcao.md` §8) | `.check` → `.ck` (`i` número, `h3`, `p`) |

## Peças soltas

- `.eyebrow` (rótulo acima do título, com traço), `h2` (título-afirmação), `.sub` (até 2 linhas).
- `.hl` roxo, `.hl-g` verde, `.hl-r` vermelho: destaque de 2 a 4 palavras, nunca frase inteira.
- `.code` + `.code__bar` + `pre`: syntax highlight manual com `.k` (palavra-chave), `.s` (string),
  `.c` (comentário), `.f` (função), `.n` (número).
- `.card__foot data-src="..."`: complemento do rodapé (fonte do dado, arquivo de origem).
- Dentro do SVG, `class="mono"` em `text` troca para a fonte mono.

## Medidas que não mudam

- Prancha 1200×675, padding 52/64, rodapé 56 px. Área útil do `.fill`: ~1072×370.
- SVG com `eyebrow` + `h2` + `.sub` de 2 linhas acima: altura até ~370. Sem `.sub`: dá para subir.
- Não calcule no olho: o `export.sh` mede e barra a prancha que estourar.

## Trocar a aparência

Cores, fontes, faixa do topo, raio e hex literais dos SVGs: `references/direcao.md`, seção 9.
O rodapé de todas as pranchas vem de `const POST = { serie, site }` no topo do `<script>`.
