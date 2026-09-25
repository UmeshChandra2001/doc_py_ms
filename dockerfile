FROM python:3.12-slim as dependencies
MAINTAINER UMESH
LABEL CHATGPT APPLICATION FROM MULTISTAGE DOCKERFILE
WORKDIR /msapp
COPY requirements.txt ./
RUN pip install --no-cache-dir --target=/msapp/modules -r requirements.txt


FROM python:3.12-slim as build
WORKDIR /msapp
COPY --from=dependencies /msapp/modules ./modules
COPY . .

FROM python:3.12-slim as prod
WORKDIR /msapp
COPY --from=dependencies /msapp/modules ./modules
COPY --from=build /msapp/app.py .
COPY --from=build /msapp/templates ./templates
COPY --from=build /msapp/static ./static
ENV PYTHONPATH=/msapp/modules
EXPOSE 5000
USER python
ENTRYPOINT ["python"]
CMD ["dist/app.py"]
