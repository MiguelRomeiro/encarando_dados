# Lidando com bancos de dados

Miguel Pereira-Romeiro 2024-08-08

## Visão geral

Este repositório foi criado e é desenvolvido por membros do EcoMol Lab com o objetivo de servir como um pequeno guia para lidar com bancos de dados sintetizados em raster, como WorldClim, MARSPEC, Bio-Oracle, Chelseas e outros. Ele inclui diferentes diretórios dedicados à obtenção de dados e análises básicas relacionados à cada um destes bancos de dados.

## Download e setup do repositório

### Download

O usuário pode baixar este repositório para o seu diretório local ou cloná-lo.

Para clonar do Github usando linha de comando:

``` r
git clone https://github.com/MiguelRomeiro/encarando_dados.git your_repo_title
```

Para baixar usando o R:

``` r
download.file(url = "https://github.com/MiguelRomeiro/encarando_dados.git", destfile = Encarando_dados.zip")
```
### Configurando o ambiente de trabalho com `renv`

O pacote `renv` configura seu amiente do R com as versões específicas dos pacotes utilizadas neste repositório para garantir que ele seja reprodutível. Para isso, é necessário ter ambos a pasta `renv` e o arquivo `renv.lock` em seu diretório raíz. Para utilizá-lo, primeiro instale o pacote normalmente utilizando:

``` r
intall.packages("renv")
library(renv)
```

Segundo, atualize o ambiente usando:

``` r
renv::restore()
```

Este comando carregará os pacotes listados no arquivo `renv.lock` em suas respectivas versões. O ambiente estpa pronto para o trabalho!


# WordClim

A base de dados do WordClim fornece dados climáticos globais em diferentes resoluções. Dentro de cada pasta, você pode encontrar scripts e dados brutos referentes a esta base de dado.

*Aviso:* Atualmente, o código aqui disponibilizado utiliza o pacote `raster`, que teve, recentemente, suporte descontinuado. Portanto, se atente à utilização das versões corretas do pacote (ver sessão acima). Estamos trabalhando para disponibilizar, em breve, uma versão atualizada do código que não dependa deste pacote.


