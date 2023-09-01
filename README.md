##### nestJs + prisma + posgresql + graphql

1. nest, prisma 설치

2. nest n <project-name>

3. 프로젝트 디렉토리 진입

4. PrismaClient 설치

   ```bash
   npm install @prisma/client
   ```

5. https://docs.nestjs.com/recipes/prisma#set-up-prisma

   1. npx prisma init

   2. ./.env DATABASE_URL 편집

      1. database 생성 필요

      2. https://www.postgresql.org/docs/current/sql-createdatabase.html

         ```sql
         CREATE DATABASE jointest
             WITH
             OWNER = kyi
             TEMPLATE = template0
             ENCODING = 'UTF8'
             LC_COLLATE = 'en_US.UTF-8'
             LC_CTYPE = 'C'
             TABLESPACE = pg_default
             CONNECTION LIMIT = -1
             IS_TEMPLATE = False;
         ```

      3. 또는 pgAdmin 이용

   3. schema 편집

      1. 모델링: https://www.prisma.io/docs/reference/api-reference/prisma-schema-reference#model
      2. Seeding(Optional)
         1. https://steelcup.home.blog/2023/09/01/prisma-seed-정리/

   4. npx prisma migrate dev --name init

6. nest prisma service+

   1. https://docs.nestjs.com/recipes/prisma#set-up-prisma

   2. nest g mo prisma

      1. 모듈 안 만들고 서비스만 만들어서 사용해도 되지만 모듈을 만들면 관리가 편함
      2. Service 만들기 전에 먼저 만들어야 알아서 같은 이름의 Service를 AppModule이 아닌 동명의 Module에 연동해주므로 먼저 생성해야 편함

   3. nest g s prisma

      1. PrismaClient 연동

         ```typescript
         @Injectable()
         export class PrismaService extends PrismaClient implements OnModuleInit {
           async onModuleInit() {
             await this.$connect();
           }
         }
         ```

   4. 모듈 생성했다면...

      이 모듈을 import하는 다른 모듈에서 서비스 사용할 수 있게 export 추가

      ```typescript
      @Module({
        providers: [PrismaService],
        exports: [PrismaService],
      })
      export class PrismaModule {}
      ```

7. 테스트

   1. PrismaModule을 생성했다면 알아서 AppModule에 import되므로 AppController에서 간단하게 테스트 가능

      ```typescript
      // prisma.service.ts
      import { Injectable, OnModuleInit } from '@nestjs/common';
      import { PrismaClient } from '@prisma/client';
      
      @Injectable()
      export class PrismaService extends PrismaClient implements OnModuleInit {
        async onModuleInit() {
          await this.$connect();
        }
      
        async getContent1() {
          return await this.content1.findMany();
        }
      }
      ```

      ```typescript
      // app.controller.ts
      import { PrismaService } from './prisma/prisma.service';
      import { Controller, Get } from '@nestjs/common';
      import { AppService } from './app.service';
      
      @Controller()
      export class AppController {
        constructor(
          private readonly appService: AppService,
          private prismaService: PrismaService,
        ) {}
      
        @Get()
        getHello(): string {
          return this.appService.getHello();
        }
      
        @Get('/content1')
        async getContent1() {
          return await this.prismaService.getContent1();
        }
      }
      ```

   2. 위 예제 주소: 