# Texto do post (`artigo.html`)

O texto e as pranchas são o mesmo argumento em duas mídias. Uma seção = uma prancha,
na mesma ordem. Quem só vê o carrossel entende; quem só lê o texto também.

## Estrutura

1. **Título**: afirmação curta + promessa, separadas por dois-pontos.
   "A IA pode errar. O seu código não precisa: determinismo com harness para entregar rápido e bem feito".
2. **Abertura** (sob a capa): cena concreta que o leitor já viveu, em 4 a 6 frases.
   Termina apontando a causa, sem ainda dar a solução.
3. **Seções**: `h2` é uma afirmação (não um rótulo). "Prompt pede, hook obriga", não "Hooks".
   Um parágrafo de 70 a 120 palavras. Lista ou bloco de código só quando o leitor vai copiar.
4. **Dado real**: pelo menos uma seção com número verificável e de onde ele veio
   (git log, planilha, log de produção). Sem dado, não invente: corte a seção.
5. **Fechamento**: checklist acionável ("para começar amanhã") e uma pergunta aberta ao leitor.

## Estilo

- Frases completas, com artigo e conector. É texto para gente, não telegrama.
- Sem travessão (—). Use ponto, vírgula ou dois-pontos.
- Sem "vale ressaltar", "nesse sentido", "é importante destacar", "no mundo de hoje".
- Primeira pessoa quando for experiência própria ("um erro que vi muitas vezes").
- Exemplo concreto antes da regra. Nome de arquivo, comando, número.
- Contraste em pares curtos fecha bem um parágrafo: "O teste lê o fonte. O usuário lê o processo."

## Bloco de imagens

Cada seção começa com:

```html
<p class="img">[imagem: <a href="file://<DIR>/img/card-NN.png">file://<DIR>/img/card-NN.png</a>] <span>· legenda curta</span></p>
```

`<DIR>` é o caminho absoluto da pasta do post: o autor clica e sobe a imagem direto no editor
(LinkedIn, Medium, blog). O bloco `.mapa` no topo lista todas as pranchas e **não é publicado**.
