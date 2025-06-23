# 빌드 단계 
FROM golang:1.13-alpine AS builder-stage

# workdir 이거는 맘대로 쓰셔도 됨여 
WORKDIR /usr/src/goapp  
COPY main.go .

# build 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/gostart 


# 다단계 빌드 - 실행 단계 
FROM scratch AS runtime 

# 빌드된 것만 복사해와서 실행시키기 
COPY --from=builder-stage /usr/local/bin/gostart /usr/local/bin/gostart 
CMD ["/usr/local/bin/gostart"] 

