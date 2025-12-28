#let font-size = (
  one: 26pt,
  small-one: 24pt,
  two: 22pt,
  small-two: 18pt,
  three: 16pt,
  small-three: 15pt,
  four: 14pt,
  small-four: 12pt,
  five: 10.5pt,
  small-five: 9pt,
)

#let font-type = (
  sun: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "SimSun",
    "Songti SC",
    "STSongti",
    "Source Han Serif SC",
    "Source Han Serif",
    "Noto Serif CJK SC",
  ),
  hei: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "SimHei",
    "Heiti SC",
    "STHeiti",
    "Source Han Sans SC",
    "Source Han Sans",
    "Noto Sans CJK SC",
  ),
  kai: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "SimKai",
    "Kaiti SC",
    "STKaiti",
    "Source Han Serif SC",
    "Source Han Serif",
    "Noto Serif CJK SC",
  ),
)

#let degree-text(degree-type) = {
  if degree-type == "master" {
    (
      zh: "硕士",
      zh-student: "硕士研究生",
      zh-thesis: "硕士学位论文",
      zh-achievement: "攻读硕士学位期间取得的成果",
      en: "Master",
    )
  } else if degree-type == "doctor" {
    (
      zh: "博士",
      zh-student: "博士研究生",
      zh-thesis: "博士学位论文",
      zh-achievement: "攻读博士学位期间取得的成果",
      en: "Doctor",
    )
  } else {
    panic("degree-type must be 'master' or 'doctor'")
  }
}

#let no-numbering-section = (
  [参考文献],
  degree-text("master").zh-achievement,  // 默认硕士，实际使用时会被覆盖
  [致谢],
  [作者简介],
)
