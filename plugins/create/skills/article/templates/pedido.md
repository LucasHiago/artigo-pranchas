# migração de banco sem downtime

Para devs que ainda param o sistema para rodar migration. A ideia é mostrar que dá para
trocar o schema com o tráfego ligado, em passos pequenos e reversíveis.

fonte: ./metricas.csv, git log do repo api-pedidos

01: capa com o banco no centro e as réplicas em volta
02: antes × depois: janela de manutenção de 40 min contra deploy com tráfego ligado
04: linha do tempo da migração, com o momento em que o tráfego troca de banco
06: pipeline expand → migrate → contract, cada passo com o comando que roda
09: gráfico de latência p95 antes e depois, dados em metricas.csv
12: checklist para a próxima migration
