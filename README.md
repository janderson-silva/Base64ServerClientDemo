Este projeto demonstra o tráfego de arquivos em formato Base64 entre um aplicativo cliente e um servidor REST. O fluxo de trabalho é o seguinte:

1. **Criação do Servidor REST:**
   - **Framework:** [Horse](https://github.com/HashLoad/horse) — Um framework para criação de servidores REST.
   - **Middlewares:** [Johnson](https://github.com/HashLoad/jhonson) — Utilizado para adicionar funcionalidades adicionais ao servidor.

2. **Criação do Aplicativo Cliente:**
   - **Biblioteca:** [RESTRequest4Delphi](https://github.com/viniciussanchez/RESTRequest4Delphi) — Biblioteca para facilitar a comunicação com o servidor REST.

**Funcionamento:**

- **Envio de Arquivos:**
  - O usuário seleciona um arquivo físico no aplicativo, que é então convertido em uma string Base64.
  - A string Base64 é enviada ao servidor utilizando o método de requisição POST.
  - No servidor, a string Base64 é armazenada em um campo BLOB para texto no banco de dados.

- **Recuperação de Arquivos:**
  - Quando o aplicativo solicita o arquivo ao servidor utilizando o método GET, o servidor retorna a string Base64 correspondente.
  - O aplicativo pode então converter a string Base64 de volta para um arquivo físico.

**Imagens do Projeto:**

<img src="https://github.com/janderson-silva/ExemploUploadFoto/assets/32645110/d7b269c3-3ee9-492c-ac04-248a6521b75b" height="48"/></a>
<img src="https://github.com/janderson-silva/ExemploUploadFoto/assets/32645110/2f1c1dd0-1b02-4140-93a4-2ad83375d4c7" height="48"/></a>

____________________________________________________________________________________________________________________________________________________________________

#### Linguagem de Programação:
![Delphi](https://img.shields.io/badge/Delphi_RAD_Studio-B22222?style=for-the-badge&logo=delphi&logoColor=white)

#### Banco de Dados:
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
<img src="https://firebirdsql.org/img/about/logos/firebird-logo-32.png" height="28"/></a>

#### Contatos:
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/janderson-silva-a2ab07b1/)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/janderson.silv/)
[![Facebook](https://img.shields.io/badge/Facebook-1877F2?style=for-the-badge&logo=facebook&logoColor=white)](https://www.facebook.com/janderson.silva.58)
