+++
layout = "post"
title = "Don't Hide Common Data"
categories = ["Rust"]
comments = true
draft = true
+++

I have a rule about a particular anti-pattern I tend to fall into when
designing a specific type of data representation in Rust.

``` rust
struct TempReport {
    barrel: f32,
    bed: f32,
    cup: f32,
}
```

``` rust
struct TempReport {
    barrel: f32,
    bed: Option<f32>,
    cup: Option<f32>,
}
```

``` rust
enum Base {
    Bed(f32),
    Cup(f32),
}

struct TempReport {
    barrel: f32,
    base: Base,
}
```

``` rust
pub struct HeaterState {
    current_temp: f32,
    set_point: Option<f32>,
}

enum Base {
    Bed(HeaterState),
    Cup(HeaterState),
}

struct TempReport {
    barrel: HeaterState,
    base: Base,
}
```

<!--more-->
