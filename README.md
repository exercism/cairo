<br>

<img align="left" width="90" height="90" src="https://raw.githubusercontent.com/exercism/website-icons/main/tracks/cairo.svg">
<p vertical-align="middle"><h1>Exercism Cairo Track</h1></p>

![configlet](https://github.com/exercism/cairo/actions/workflows/configlet.yml/badge.svg)&nbsp;&nbsp;&nbsp;&nbsp;![test](https://github.com/exercism/cairo/actions/workflows/test.yml/badge.svg)

<br>

Hi. &nbsp;👋🏽 &nbsp;👋 &nbsp;**We are happy you are here.**&nbsp; 🎉&nbsp;🌟

<br>

**`exercism/cairo`** is one of many programming language tracks on [exercism(dot)org][exercism-website].
This repo holds all the instructions, tests, code, & support files for Cairo _exercises_ currently under development or implemented & available for students.

Some Exercism language tracks have a **syllabus** which is meant to teach the language step-by-step.
The Cairo track's syllabus is a work in progress and it's not activated yet.
All exercises presented to students are **practice exercises**.
Students are expected to learn the language themselves, for example with the [official book][the-cairo-programming-language], and practice with our exercises.

<br>

<div>
<span>
<img align="left" height="60" width="85" src="https://user-images.githubusercontent.com/5923094/204436863-2ebf34d1-4b16-486b-9e0a-add36f4c09c1.svg">
</span>
<span align="left">

🌟🌟&nbsp; Please take a moment to read our [Code of Conduct][exercism-code-of-conduct] &nbsp;🌟🌟<br>
It might also be helpful to look at [Being a Good Community Member][being-a-good-community-member] & [The words that we use][the-words-that-we-use].<br>
Some defined roles in our community: [Contributors][exercism-contributors] **|** [Mentors][exercism-mentors] **|** [Maintainers][exercism-track-maintainers] **|** [Admins][exercism-admins]

</span></div>

<br>
<img align="left" width="90" height="85" src="https://raw.githubusercontent.com/exercism/website-icons/main/exercises/health-statistics.svg">

We&nbsp;💛&nbsp;💙 &nbsp; our community.<br>
**`But our maintainers are not accepting community contributions at this time.`**<br>
Please read this [community blog post][freeing-maintainers] for details.

<br>
<img align="left" width="95" height="90" src="https://raw.githubusercontent.com/exercism/website-icons/main/exercises/boutique-suggestions.svg">

Here to suggest a new feature or new exercise?? **Hooray!** &nbsp;🎉 &nbsp;<br>
We'd love if you did that via our [Exercism Community Forum](https://forum.exercism.org/).<br>
Please read [Suggesting Exercise Improvements][suggesting-improvements] & [Chesterton's Fence][chestertons-fence].<br>
_Thoughtful suggestions will likely result faster & more enthusiastic responses from volunteers._

<br>
<img align="left" width="85" height="80" src="https://raw.githubusercontent.com/exercism/website-icons/main/exercises/word-search.svg">

✨&nbsp;🦄&nbsp; _**Want to jump directly into Exercism specifications & detail?**_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Structure][exercism-track-structure] **|** [Tasks][exercism-tasks] **|** [Concepts][exercism-concepts] **|** [Concept Exercises][concept-exercises] **|** [Practice Exercises][practice-exercises] **|** [Presentation][exercise-presentation]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Writing Style Guide][exercism-writing-style] **|** [Markdown Specification][exercism-markdown-specification] (_✨ version in [contributing][website-contributing-section] on exercism.org_)

<br>

## Testing

Tests currently use Cairo v2.12.0 (included with Scarb v2.12.0).

To test all exercises, run `./bin/verify-exercises`.
This command will iterate over all exercises and check to see if their exemplar/example implementation passes all the tests.

To test a single exercise, run `./bin/verify-exercises <exercise-slug>`.

### Track linting

[`configlet`](https://exercism.org/docs/building/configlet) is an Exercism-wide tool for working with tracks. You can download it by running:

```shell
$ ./bin/fetch-configlet
```

Run its [`lint` command](https://exercism.org/docs/building/configlet/lint) to verify if all exercises have all the necessary files and if config files are correct:

```shell
$ ./bin/configlet lint

The lint command is under development.
Please re-run this command regularly to see if your track passes the latest linting rules.

Basic linting finished successfully:
- config.json exists and is valid JSON
- config.json has these valid fields:
    language, slug, active, blurb, version, status, online_editor, key_features, tags
- Every concept has the required .md files
- Every concept has a valid links.json file
- Every concept has a valid .meta/config.json file
- Every concept exercise has the required .md files
- Every concept exercise has a valid .meta/config.json file
- Every practice exercise has the required .md files
- Every practice exercise has a valid .meta/config.json file
- Required track docs are present
- Required shared exercise docs are present
```

### Markdown linting

To check for markdown files' formatting issues, open a bash terminal and run:

```shell
./bin/lint_markdown.sh
```

You can even pass the `--fix` flag to automatically fix those issues that can be fixed automatically:

```shell
./bin/lint_markdown.sh --fix
```

### Exercise formatting

To format Cairo files, open a bash terminal and run:

```shell
./bin/format_exercises.sh
```

### Format all

To run all formatting scripts at once, open a bash terminal and run:

```shell
./bin/format_all.sh
```

<br>


## Exercism Cairo Track License

This repository uses the [MIT License](/LICENSE).

[being-a-good-community-member]: https://github.com/exercism/docs/tree/main/community/good-member
[chestertons-fence]: https://github.com/exercism/docs/blob/main/community/good-member/chestertons-fence.md
[concept-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[exercise-presentation]: https://github.com/exercism/docs/blob/main/building/tracks/presentation.md
[exercism-admins]: https://github.com/exercism/docs/blob/main/community/administrators.md
[exercism-code-of-conduct]: https://exercism.org/docs/using/legal/code-of-conduct
[exercism-concepts]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[exercism-contributors]: https://github.com/exercism/docs/blob/main/community/contributors.md
[exercism-markdown-specification]: https://github.com/exercism/docs/blob/main/building/markdown/markdown.md
[exercism-mentors]: https://github.com/exercism/docs/tree/main/mentoring
[exercism-tasks]: https://exercism.org/docs/building/product/tasks
[exercism-track-maintainers]: https://github.com/exercism/docs/blob/main/community/maintainers.md
[exercism-track-structure]: https://github.com/exercism/docs/tree/main/building/tracks
[exercism-website]: https://exercism.org/
[exercism-writing-style]: https://github.com/exercism/docs/blob/main/building/markdown/style-guide.md
[freeing-maintainers]: https://exercism.org/blog/freeing-our-maintainers
[practice-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md
[suggesting-improvements]: https://github.com/exercism/docs/blob/main/community/good-member/suggesting-exercise-improvements.md
[the-words-that-we-use]: https://github.com/exercism/docs/blob/main/community/good-member/words.md
[website-contributing-section]: https://exercism.org/docs/building
[the-cairo-programming-language]: https://book.cairo-lang.org/
