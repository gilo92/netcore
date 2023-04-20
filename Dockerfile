FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build-env
WORKDIR /
       
COPY *.csproj ./
RUN dotnet restore
       
COPY . ./app/
RUN dotnet publish -c Release -o out
        
FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim
WORKDIR /app
COPY --from=build-env /app/out .
        
EXPOSE 80
        
ENTRYPOINT ["dotnet", "alloy-docker.dll"]