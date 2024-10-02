// @ts-check

"use strict";

// BUG: for some reason this rule does not detect sentences starting with *, _ or `
// so these have to be manually placed on new lines

const indentFor = (string, indentation) => {
  const regex = new RegExp(
    "^(?<indents>(" + indentation + ")*)(?<adds>- |> |>|\\* |\\d+\\. )?",
  );
  const match = regex.exec(string);
  if (!match) {
    return "";
  }
  let indentSize = 0;
  if (match.groups?.indents) {
    indentSize = match.groups.indents.length / indentation.length;
  }
  if (match.groups?.adds) {
    if (match.groups.adds.includes(">")) {
      return indentation.repeat(indentSize) + match.groups.adds;
    }
    indentSize++;
  }
  return indentation.repeat(indentSize);
};

const isAfterIgnoredWord = (ignoredWords, line, i) => {
  for (const ignoredWord of ignoredWords) {
    const lastWordInLine = line.substring(i - ignoredWord.length, i);
    if (ignoredWord === lastWordInLine.toLowerCase()) {
      return true;
    }
  }

  return false;
};

module.exports = {
  names: ["max-one-sentence-per-line"],
  description: "Max 1 sentence should be on a line",
  information: new URL(
    "https://github.com/aepfli/markdownlint-rule-max-one-sentence-per-line",
  ),
  tags: ["sentences"],
  function: (params, onError) => {
    const ignoredWords = params.config.ignored_words || [
      "ie",
      "i.e",
      "eg",
      "e.g",
      "etc",
      "ex",
    ];
    const lineEndings = params.config.line_endings || [".", "?", "!"];
    const sentenceStartRegex =
      params.config.sentence_start || "^\\s+(\\w|[*_'\"`])";
    const indentation = params.config.indentation || "  ";

    const sentenceStart = new RegExp(sentenceStartRegex);

    const relevantTokens = [];
    for (let i = 0; i < params.tokens.length; i++) {
      const token = params.tokens[i];
      if (
        token.type === "paragraph_open" &&
        params.tokens[i + 1].type === "inline"
      ) {
        relevantTokens.push(params.tokens[i + 1]);
      }
    }

    for (const relevantToken of relevantTokens) {
      for (const token of relevantToken.children) {
        const lineNumber = token.lineNumber;
        if (token.type === "text") {
          const content = token.content;
          for (let i = 0; i < content.length - 2; i += 1) {
            if (lineEndings.includes(content[i])) {
              const sentence = sentenceStart.exec(content.substr(i + 1));
              if (
                sentence !== null &&
                !isAfterIgnoredWord(ignoredWords, content, i)
              ) {
                const spaces = sentence[1];
                const pointInLine = token.line.indexOf(content) + i;
                onError({
                    lineNumber,  // Report error on paragraph start
                    detail: "Each sentence should be on its own line.",
                    fixInfo: {
                    editColumn: pointInLine + 2,
                    deleteCount: spaces.length,
                      insertText:
                        "\n" + indentFor(relevantToken.line, indentation),
                    }
                  });
              }
            }
          }
        }
      }
    }
  },
};
