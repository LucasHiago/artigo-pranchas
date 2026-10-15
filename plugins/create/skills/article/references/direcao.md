# Direção visual

Cada post tem um mundo visual próprio. Entre um post e outro, a única coisa fixa é o
rodapé (título curto do post + URL da empresa). Capa, paleta, fontes, moldura das
pranchas e o jeito de desenhar diagrama são decididos **para este post**, a partir do
tema, e registrados em `artigo-<slug>/direcao.md` antes do rascunho ser aprovado.

O template `sessoes.html` é o design system **mecânico** (medidas, trava de estouro,
rodapé, IIFEs que desenham SVG). A aparência dele (roxo, Inter, faixa em gradiente,
eyebrow, anel radial na capa) é só um exemplo, e é exatamente o visual que não deve
sair de novo por padrão.

## 0. Skills de design

Se a sessão tiver as skills `taste-skill` e/ou `impeccable`, carregue-as (tool `Skill`)
neste passo e use delas só o que serve para pranchas estáticas 1200×675:

- **taste-skill:** o "Design Read" de uma linha, os dials de variância e densidade
  (movimento não se aplica: PNG não anima) e a lista de AI tells (seção 9).
- **impeccable:** de `reference/new-work.md`, o trecho "Create or replace the visual
  world" (mecanismo, mundo do público, candidatos, o que é o lugar-comum) e o passo
  "Commit the world" (estratégia de cor, fontes). Antes de escrever o HTML, leia
  `reference/craft-floor.md`.
- **Não rode** os scripts do impeccable (`context`, `concept-seed`, `serve-question`,
  `generate-image`) nem crie PRODUCT.md/DESIGN.md: aqui a aprovação é o rascunho, e a
  imagem final é SVG desenhado, não imagem gerada.

Sem as skills, as seções abaixo são o resumo do que elas pedem. Siga do mesmo jeito.

## 1. Memória: o que já saiu

Antes de escolher, veja o que os posts anteriores usaram, para não repetir:

```bash
ls -dt ./artigo-*/ ../artigo-*/ 2>/dev/null | head -5
grep -H '^\(capa\|paleta\|fontes\|moldura\|mundo\):' ./artigo-*/direcao.md ../artigo-*/direcao.md 2>/dev/null
```

Post antigo sem `direcao.md`: abra o `img/card-01.png` dele e anote capa, cor e fonte.
O novo post **difere dos 3 mais recentes** em: arquétipo de capa, família de paleta,
fonte display e moldura. Registre isso na linha `evita:` do `direcao.md`.

## 2. Leitura e mundo

1. **Leitura**, em uma linha: `post técnico sobre <tema> para <público>, com linguagem
   <vibe>, puxando para <família estética>`. O público escolhe a estética, não o gosto.
2. **Mecanismo**: em uma frase, o que o tema faz (o que bloqueia o quê, o que vaza para
   onde, o que muda entre antes e depois). É ele que a capa e os diagramas desenham.
3. **Mundo**: liste 5 artefatos, notações ou lugares que o público conhece de cor e que
   carregam o mecanismo. Exemplos de família: saída de terminal, diff de PR, diagrama de
   sequência, planta baixa, mapa de metrô, prontuário, nota fiscal, painel de aeroporto,
   etiqueta de embalagem, manual de montagem, gráfico de osciloscópio, ficha de
   inspeção, carimbo de cartório, cartaz suíço, livro-razão. Pelo menos 3 famílias de
   material diferentes. Escolha um: ele dá a gramática de todas as pranchas.
4. **Lugar-comum**: nomeie o visual que qualquer post desse tema teria (e o oposto
   previsível dele). Nenhum dos dois entra. Para este plugin, o lugar-comum fixo é:
   texto à esquerda + rede radial à direita, roxo com gradiente, Inter, eyebrow com traço.

## 3. `direcao.md`

Uma linha por chave, nesta ordem (as chaves são lidas pelo passo 1 dos próximos posts):

```
leitura: <a linha do Design Read>
mecanismo: <uma frase>
mundo: <artefato escolhido> · <por que carrega o mecanismo>
capa: <arquétipo> · <o que ela mostra deste post>
paleta: <família> · <estratégia> · fundo #… texto #… primária #… acento #…
fontes: <display> / <texto> / <mono>
moldura: <fundo do card, faixa/borda, raio, estilo do rodapé, eyebrow sim/não>
gramática: <como diagrama desenha: traço, nó, seta, preenchimento, rótulo>
ritmo: <quais pranchas são pico (fundo invertido, sangria) e quais respiram>
evita: <o que dos últimos posts não repete>
```

Se uma linha soa como humor ("moderno e limpo"), a direção ainda não foi decidida.
Tem que dar para reconhecer o post com o texto apagado.

## 4. Capa

A capa é sempre **nova**: nunca o bloco `01` do catálogo. Ela desenha o mecanismo
**deste** post com um só movimento dominante; o resto fica quieto. Arquétipos (escolha
um que os 3 últimos posts não usaram, ou invente outro e dê nome a ele):

| arquétipo | o que é | serve quando |
|---|---|---|
| tipográfica | o título É a imagem: corpo gigante, corte, sangria, uma palavra em cor | a tese cabe em 4 a 7 palavras e é forte |
| artefato do mundo | o objeto do mundo escolhido, desenhado (terminal, nota, prontuário, planta) com o detalhe que prova a tese | o tema vive dentro de uma ferramenta ou documento |
| número-herói | um dado real enorme com a fonte embaixo | existe um número verificável que choca |
| antes/depois cortado | a prancha dividida na diagonal ou ao meio, dois estados | a tese é uma mudança |
| mecanismo em escala cheia | o diagrama do mecanismo ocupando a prancha, título pequeno num canto | o mecanismo é o argumento |
| recorte ampliado | uma linha de código, log ou mensagem em zoom, com a anotação | um detalhe pequeno causa o problema |
| mapa / percurso | o caminho do dado ou do pedido como mapa de linhas | o tema é fluxo entre lugares |
| pilha / corte | corte transversal de camadas, como desenho técnico | o tema são camadas |
| grade de evidências | muitas ocorrências pequenas e uma destacada | o problema é volume ou padrão |
| manchete | composição de jornal/cartaz: chamada, linha fina, um dado | o tema é notícia ou virada |

Teste: cubra o título. Se a imagem servia para outro tema, redesenhe.

## 5. Paleta

Escolha a **estratégia** antes das cores: contida (neutros + um acento), comprometida
(uma cor cobre 30 a 60% da prancha), inundada (a prancha é a cor) ou escura (fundo
escuro, uso noturno, terminal). Varie entre posts.

Famílias para girar (não repita a dos 3 últimos posts): monocromo + um acento saturado;
cobalto + papel; floresta + osso + âmbar; terracota + ardósia; oliva + tijolo; preto
quente + tan; tinta azul + vermelho de revisão; grafite + amarelo de sinalização;
verde de terminal sobre quase-preto; laranja de segurança + cinza frio.

- Evite como padrão: roxo/violeta com gradiente (o "roxo de IA") e creme/bege + marrom.
  Só entram se o tema ou a marca pedirem, com motivo escrito em `direcao.md`.
- Cor da marca da empresa: só se a pessoa pedir. Aí ela vira a primária ou só o selo
  do rodapé; a paleta continua sendo do post.
- Vermelho e âmbar ficam reservados para erro e alerta, em qualquer paleta.
- Um acento por post. Sem preto puro (#000) e sem branco puro como fundo de prancha.
- Contraste: texto ≥ 4,5:1, texto grande ≥ 3:1, inclusive dentro do SVG.

## 6. Fontes

Fontes com acento do português, do Google Fonts. Display com personalidade, texto
legível em 13 a 18 px, mono só para código, comando e número de medida (mono como
fantasia de "técnico" é tique). Não repita a display dos 3 últimos posts.

- Display: Bricolage Grotesque, Archivo (larguras expandidas), Familjen Grotesk,
  Schibsted Grotesk, Hanken Grotesk, Onest, Unbounded, Big Shoulders Display, Anybody,
  Red Hat Display, Epilogue, Sora, Geist, Manrope, Funnel Display, Host Grotesk.
- Texto: a própria display em peso regular, ou Geist, Hanken Grotesk, Onest, Figtree,
  Public Sans, Atkinson Hyperlegible.
- Mono: JetBrains Mono, Geist Mono, Fira Code, Martian Mono, Red Hat Mono, Azeret Mono,
  Spline Sans Mono.
- Evite como display: Inter, Space Grotesk, Space Mono, IBM Plex, DM Sans, Outfit,
  Plus Jakarta Sans, Syne, Instrument Sans. Serifa só com motivo do tema (editorial,
  documento histórico), nunca Fraunces nem Instrument Serif.
- Destaque dentro do título: peso ou cor da mesma família. Não misture família.

## 7. Moldura e ritmo

A moldura muda por post: é o que mais denuncia "mesmo template".

- Faixa do topo: gradiente, cor sólida, régua fina, borda lateral, nenhuma.
- Fundo do card: claro, escuro, cor da paleta, papel quadriculado/milimetrado desenhado
  em SVG, se o mundo pedir.
- Raio: 0 (técnico, impresso) a 10 px (interface). Um só valor no post.
- Eyebrow (rótulo com traço acima do título): por padrão **não**. O título se sustenta.
  Se o mundo tiver um equivalente real (número de folha, carimbo, código de ficha), use ele.
- Rodapé: mesma informação sempre (título curto · fonte do dado / URL), estilo do post.
- Ritmo: 2 a 3 pranchas-pico com fundo invertido ou sangria, espaçadas; as outras
  respiram. Todas iguais em peso viram papel de parede.

## 8. Blocos do catálogo

- Capa: sempre nova (seção 4).
- Nenhum layout do catálogo mais de uma vez no post.
- Pelo menos 1/3 das pranchas (fora a capa) marcadas "novo", desenhadas a partir do
  mundo escolhido.
- Bloco do catálogo reaproveitado é **redesenhado na gramática do post** (traço, nó,
  seta, rótulo), não só recolorido. Mantenha a mecânica (IIFE, medidas), troque a forma.
- Fechamento: a checklist 3×2 de cards iguais (`16`) é o último recurso. Prefira o
  formato do mundo: ficha de inspeção, comando para colar, lista numerada única,
  antes/depois de um arquivo, cartão de bolso.
- Sem 3 cards iguais lado a lado como estrutura, sem card dentro de card, sem borda
  lateral colorida grossa como enfeite, sem texto em gradiente.

## 9. Aplicar no `sessoes.html`

1. `<link>` do Google Fonts com as três famílias; `--display`, `--font`, `--mono` no `:root`.
2. Cores no `:root` (`--bg`, `--surface`, `--text*`, `--border*`, `--primary*`, `--accent*`)
   e `--frame` (fundo da faixa do topo; `none` remove).
3. Hex literais dos SVGs e IIFEs, trocados no arquivo todo:

   ```bash
   sed -i -e 's/#7E22CE/<primária>/gI' -e 's/#A855F7\|#9333EA/<primária clara>/gI' \
     -e 's/#581C87/<primária escura>/gI' -e 's/#E9D5FF\|#C4B5FD/<primária bem clara>/gI' \
     -e 's/rgba(168,85,247,/rgba(<r>,<g>,<b>,/g' \
     -e 's/#059669\|#10B981/<acento>/gI' -e 's/#047857/<acento escuro>/gI' sessoes.html
   ```

   Fundo escuro: troque também os neutros (`#FAFAF7` fundo, `#fff`/`#FFFFFF` superfície,
   `#1A1A1F` texto, `#4B4B5C` texto médio, `#78788C` texto baixo, `#E5E5DC`/`#D0D0C5`
   bordas) e confira um a um os `#fff` que eram texto sobre cor.
4. `.code` (bloco de código) pode continuar escuro em post claro; em post escuro, dê a
   ele um tom diferente do fundo para não sumir.

## 10. Conferência (passo 5 da skill)

- **Irmãos:** abra o `card-01.png` deste post e o dos 3 posts anteriores. Se parecem da
  mesma série de template, a direção não foi aplicada: refaça capa e moldura.
- **Esqueleto:** apague mentalmente o texto de uma prancha. A estrutura ainda diz o que
  ela é? Se só funciona com as palavras, o design está no tamanho da letra.
- **Um foco por prancha:** dois elementos disputando o mesmo peso = prancha gritando.
  Mantenha o mais forte, aquiete o outro.
- **Direção cumprida:** cada linha do `direcao.md` aparece nas pranchas.
