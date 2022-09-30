# vscode-codeql-starter

A starter workspace to use with the [CodeQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=github.vscode-codeql). For more information, see the [`vscode-codeql` repo](https://github.com/github/vscode-codeql/).

## Instructions

1. Install [Visual Studio Code](https://code.visualstudio.com).
1. Install the [CodeQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=github.vscode-codeql).
1. Clone this repository to your computer.
    - Make sure to include the submodules, either by `git clone --recursive` or by `git submodule update --init --remote` after clone.
    - Use `git submodule update --remote` regularly to keep the submodules up to date.
1. In VS Code, click File > Open Workspace. Select the file `vscode-codeql-starter.code-workspace` in your checkout of this repository.
1. You will see several folders open in the left sidebar:
    - The `ql` folder contains the [open-source CodeQL standard libraries](https://github.com/github/codeql/tree/codeql-cli/latest) for C/C++, C#, Go, Java, JavaScript/Typescript, Python, and Ruby. It tracks the branch tagged `codeql-cli/latest` in https://github.com/github/codeql. You can run the standard queries from here, and browse the libraries.
    - The folders named `codeql-custom-queries-<language>` are ready for you to start developing your own custom queries for each language, while using the standard libraries. There are some example queries to get you started.
1. Follow the [documentation for the CodeQL extension](https://codeql.github.com/docs/codeql-for-visual-studio-code/) to learn how to set up the extension, add a database and run queries against it. Have fun!

## Using the `vscode-codeql-starter` in a private repository

If you want to privately share your CodeQL queries with your teammates using this project as a template:

1. Create an empty, private project in the organization you want.
1. Clone this project locally: `git clone git@github.com:github/vscode-codeql-starter.git`
1. Add a remote to the local copy `git remote add my-org git@github.com:<MY-ORG>/vscode-codeql-starter.git`
1. Push the code to the new remote: `git push my-org main`

GitHub does not allow private forks of public repositories.

## Contributing

This project welcomes contributions. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Reporting issues

Issues and suggestions should be reported in the [`vscode-codeql` repo](https://github.com/github/vscode-codeql/issues/new/choose).

## License

This project is [licensed](LICENSE.md) under the MIT License. 

The CodeQL extension for Visual Studio Code is [licensed](https://github.com/github/vscode-codeql/blob/main/extensions/ql-vscode/LICENSE.md) under the MIT License. The version of CodeQL used by the CodeQL extension is subject to the [GitHub CodeQL Terms & Conditions](https://securitylab.github.com/tools/codeql/license).
