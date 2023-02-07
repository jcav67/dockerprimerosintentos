# FROM --platform=linux/amd64 node:19.2-alpine3.17'
FROM  node:19.2-alpine3.17 as deps

#por defecto viene con una carpeta /app /usr /lib
# WORKDIR es un equivalente a cd app
WORKDIR /app

#copia archivos  a una carpeta destino  ./ quiere decir la carpeta actual
COPY package.json ./

# se ejectua el comando para installar dependencias, el RUN permite ejecutar comandos
RUN npm install
# -----------------------------------------------------------------------------------------
# cada front es una nueva estapa del multi-state build
FROM  node:19.2-alpine3.17 as builder

WORKDIR /app

# copia de archivos desde la etapa anterior al nuevo state
COPY --from=deps /app/node_modules  ./node_modules  
#otra forma de destino es /app/node_modules

# una forma para copiar todo es . ., en este caso copiará todo menos lo que haya en el docker ignore
COPY . .

#realizar   los test
RUN npm run test
# -----------------------------------------------------------------------------------------
#ultima etapa 
FROM  node:19.2-alpine3.17 as runner

# Eliminar archivos y directorios no necesarios en PROD
# RUN rm -rf tests && rm -rf node_modules

WORKDIR /app

COPY package.json ./

# instalar unicamente dependencias de produccion
RUN npm install --prod

#Para copiar archivos y carpetas especificas
COPY app.js ./
COPY tasks/ /app/tasks

#CMD serie de comando que se quieren ejecutar, por lo general la ultima ya que dice como se inicia la aplicacion
CMD [ "node","app.js" ]