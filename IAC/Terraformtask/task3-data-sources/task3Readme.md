# TASK 3 — Data Sources (READ vs CREATE)

## 🎯 Goal: Learn the difference between:

```
“Terraform creates this”
vs
“Terraform reads existing things”
```

### What you’ll build

- Pull existing Docker image using data

- Use it in container

- Output image digest

### Concepts

- data "docker_image"

- When Terraform does not own lifecycle

- Outputs

- Interpolation


### Key lesson

- Data sources do not create state the same way resources do.

---