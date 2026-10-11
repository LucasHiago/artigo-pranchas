# artigo-pranchas

Skill de [Claude Code](https://claude.com/claude-code) que escreve post técnico em duas mídias:
o **texto** pronto para colar no LinkedIn, Medium ou blog, e o **carrossel de pranchas**
1200×675 em HTML/SVG, exportado para PNG.

| | |
|---|---|
| ![capa](docs/exemplo-01.png) | ![pipeline](docs/exemplo-06.png) |
| ![grafo](docs/exemplo-08.png) | ![dado real](docs/exemplo-11.png) |

## Instalar

```
/plugin marketplace add LucasHiago/artigo-pranchas
/plugin install create@artigo-pranchas
```

Na instalação o Claude Code pergunta a **URL da sua empresa**, que vai no rodapé de toda prancha.
O outro lado do rodapé é o título curto de cada post. Para trocar a URL depois:

```
/plugin configure create@artigo-pranchas
```

## Usar

Dê o tema e uma descrição curta do que quer dizer:

```
/create:article como a gente versiona o banco neste repo. Para devs que ainda rodam migration na mão; a ideia é mostrar que o CI faz isso melhor
```

Para controlar o que cada imagem mostra, descreva as pranchas que quiser, uma por linha
(ou passe o caminho de um `.md` com essas linhas). As que ficarem sem descrição a skill decide:

```
/create:article migração de banco sem downtime
01: capa com o banco no centro e as réplicas em volta
04: linha do tempo da migração, com o momento em que o tráfego troca de banco
09: gráfico de latência antes e depois, dados em metricas.csv
```

Ou peça em linguagem natural ("escreve um post com pranchas sobre ..."), que a skill dispara sozinha.

A skill segue sempre os mesmos passos:

1. **rascunho** em `artigo-<slug>/rascunho.md`: o texto inteiro, seção por seção, e embaixo de cada
   seção a ideia da imagem (o que mostra, layout, dado). A skill **para e pede aprovação**: responda
   `ok`, ou aponte o ajuste (`03: troca o exemplo`, `07 imagem: mostra o fluxo ao contrário`).
   Nada de HTML antes do `ok`;
2. **pranchas** em `artigo-<slug>/sessoes.html`, partindo de um catálogo de 16 layouts
   (pipeline, grafo, timeline, matriz 2×2, queijo suíço, código ruim × bom, gráfico com dado real...)
   ou de um SVG novo quando nenhum layout mostra o mecanismo do tema;
3. **export** com `export.sh`, que gera `img/card-NN.png` em 2× e **falha se algum texto estourar**
   a prancha (o card tem altura fixa, e texto cortado sumiria calado do PNG);
4. **texto** em `artigo.html`: uma seção por prancha, na mesma ordem, com o mapa das imagens.

## O que vem

```
plugins/create/skills/article/
  SKILL.md                 os passos
  templates/sessoes.html   design system + 16 pranchas de exemplo (é o catálogo)
  templates/artigo.html    esqueleto do texto
  templates/export.sh      exportador com trava de estouro
  references/layouts.md    qual layout para qual ideia; como trocar a marca
  references/texto.md      estrutura e estilo do texto
```

As pranchas de exemplo são o post "A IA pode errar. O seu código não precisa", sobre harness
de IA para código. A URL configurada substitui o rodapé; cores em `references/layouts.md` → *Trocar a marca*.

## Requisitos

- Google Chrome ou Chromium no `PATH` (ou `CHROME=/caminho/do/binario`) para o export.
- Fontes Inter e JetBrains Mono vêm do Google Fonts; o export precisa de rede.

## Licença

MIT
