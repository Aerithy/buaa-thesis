#import "@preview/subpar:0.2.2"

#import "src/constant.typ": font-size, font-type
#import "src/cover.typ": cover
#import "src/abstract.typ": abstract, abstract-en
#import "src/outlines.typ": heading-outline, image-outline, table-outline
#import "src/header-footer.typ": append-header, leading-footer, main-footer, main-header
#import "src/main-format.typ": show-main
#import "src/bib.typ": bib
#import "src/utils.typ": degree-text, heading-numbering, reset-page
#import "src/algorithm.typ": *

#let sub-fig = subpar.grid.with(
  supplement: "图",
  numbering: it => {
    let numbers = counter(heading).at(here()).slice(0, 1)
    numbering("1.1", ..numbers, it)
  },
  numbering-sub-ref: (..nums) => {
    let numbers = counter(heading).at(here()).slice(0, 1)
    numbering("1.1a", ..numbers, ..nums)
  },
  show-sub-caption: (num, it) => {
    set text(size: font-size.five)
    set par(leading: 0.8em)

    it
  },
)

#let abstract-render(abstract: [], abstract-en: []) = {
  if abstract != [] {
    abstract
    pagebreak()
  }

  if abstract-en != [] {
    abstract-en
    pagebreak()
  }
}

#let outlines-render() = {
  heading-outline()
  pagebreak()

  context {
    if query(figure.where(kind: image)).len() > 0 {
      image-outline()
      pagebreak()
    }
  }

  context {
    if query(figure.where(kind: table)).len() > 0 {
      table-outline()
      pagebreak()
    }
  }
}

#let append-render(
  bibliography: none,
  achievement: [],
  acknowledgements: [],
  cv: [],
  degree-type: "master",
) = {
  let dt = degree-text(degree-type)

  if bibliography != none {
    [= 参考文献]
    bib(bibliography: bibliography)

    if achievement != [] or acknowledgements != [] or cv != [] {
      pagebreak()
    }
  }

  if achievement != [] {
    [= #dt.zh-achievement]
    achievement

    if acknowledgements != [] or cv != [] {
      pagebreak()
    }
  }

  if acknowledgements != [] {
    [= 致谢]
    acknowledgements

    if cv != [] {
      pagebreak()
    }
  }

  if cv != [] {
    [= 作者简介]
    cv
  }
}

#let thesis(
  title: (zh: "", en: ""),
  author: (zh: "", en: ""),
  teacher: (zh: "", en: ""),
  teacher-degree: (zh: "", en: ""),
  college: (zh: "", en: ""),
  major: (
    discipline: "",
    direction: "",
    discipline-first: "",
    discipline-direction: "",
  ),
  date: (
    start: "",
    end: "",
    summit: "",
    defense: "",
  ),
  degree: (zh: "工学硕士", en: "Master of Engineering"),
  degree-type: "master", // 学位类型：master 或 doctor
  lib-number: "",
  stu-id: "",
  abstract: [],
  abstract-en: [],
  bibliography: none,
  achievement: [],
  acknowledgements: [],
  cv: [],
  is-print: false,
  body,
) = {
  set text(size: font-size.small-four, font: font-type.sun, lang: "cn")
  set par(leading: 1.25em, spacing: 1.25em, justify: true)

  cover(
    title: title,
    author: author,
    teacher: teacher,
    teacher-degree: teacher-degree,
    college: college,
    major: major,
    date: date,
    degree: degree,
    lib-number: lib-number,
    stu-id: stu-id,
    is-print: is-print,
    degree-type: degree-type,
  )

  reset-page()

  show: page.with(footer: leading-footer())

  abstract-render(abstract: abstract, abstract-en: abstract-en)

  outlines-render()

  reset-page()

  show: page.with(header: main-header(degree-type: degree-type), footer: main-footer())

  [
    #show: show-main

    #body

    #show: page.with(header: append-header())

    #append-render(
      bibliography: bibliography,
      achievement: achievement,
      acknowledgements: acknowledgements,
      cv: cv,
      degree-type: degree-type,
    )
  ]
}
