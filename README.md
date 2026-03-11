# Cover Letter CLI

This CLI allows you to **generate a cover letter** using a job description and an existing cover letter template.

---

## Installation

1. Clone the repository:

```bash
git clone https://github.com/ajoanny/applicant.git
cd applicant
```

2. Install dependencies:

```bash
bundle install
```

3. Make the CLI executable:

```bash
chmod +x bin/applicant.rb
```

---

## Environment Variables

The CLI requires two environment variables:

* `LLM_MODEL` – the name of the LLM model you want to use.
* `OLLAMA_URL` – the URL of your Ollama server (e.g., `http://localhost:11434`).

You can set them in a `.env` file at the root of your project.

---

## Docker Setup

This project includes a **Docker Compose** setup with an **Ollama container**. Start the container:

```bash
docker-compose up -d
```

To pull a model inside the Ollama container:

```bash
sudo docker exec -it ollama ollama pull <model-name>
```

Replace `<model-name>` with the **model you want to use**.`LLM_MODEL` should be the model name used by Ollama.
You can use the Ollama API [List models](https://docs.ollama.com/api/tags) to find the name of the LLM model. 

[Ollama API Documentation](https://docs.ollama.com/api/introduction)

---

## Usage

The CLI provides the `generate` command:

```bash
bin/applicant.rb generate [OPTIONS]
```

### Options

* `--cover_letter=PATH` (default: `./config/cover-letter.txt`)
  Path to your existing cover letter template.

* `--job=PATH`
  Path to the job description file. If not provided, the CLI will read from **STDIN**.

---

### Examples

#### 1. Using a job description file

```bash
bin/applicant.rb generate --cover_letter=config/cover-letter.txt --job=job-description.txt
```

#### 2. Pasting the job description directly

```bash
bin/applicant.rb generate --cover_letter=config/cover-letter.txt
```

Then **paste the job description** into the terminal and finish with **EOF**:

* **Linux/macOS:** `Ctrl+D`
* **Windows:** `Ctrl+Z` then `Enter`

---

### Example Piped Usage

```bash
cat job-description.txt | bin/applicant.rb generate --cover_letter=config/cover-letter.txt
```

---

### Help Command

To see all available commands or get help for a specific command:

```bash
bin/applicant.rb help
bin/applicant.rb help generate
```

---

### Notes

* The CLI reads the job description, combines it with the cover letter template, and generates a new cover letter output in the terminal.
* Ensure your template file exists and is readable.
* Make sure the Ollama container is running and the model you want is pulled before generating the cover letter.
* **Environment variables** `LLM_MODEL` and `OLLAMA_URL` must be set before running the CLI.

