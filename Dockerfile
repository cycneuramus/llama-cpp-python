FROM python:3-slim-bullseye

ENV HOST 0.0.0.0

RUN apt-get update && apt-get install -y \
	build-essential \
	libopenblas-dev \
	ninja-build

RUN python -m pip install --no-cache-dir --upgrade \
	cmake \
	fastapi \
	pip \
	pydantic-settings \
	pytest \
	scikit-build \
	setuptools \
	sse-starlette \
	uvicorn

RUN CMAKE_ARGS="-DLLAMA_CLBLAST=on" \
	FORCE_CMAKE=1 \
	LLAMA_CLBLAST=1 \
	pip install --no-cache-dir llama_cpp_python --verbose

CMD [ "python3", "-m", "llama_cpp.server" ]
