import { PrismaClient } from '@prisma/client';
import * as _ from 'lodash';

const prisma = new PrismaClient();
async function main() {
  console.log('Start seeding...');

  console.log('Create Category1...');
  await prisma.category1.createMany({
    data: [
      {
        name: 'apple',
      },
      {
        name: 'banana',
      },
      {
        name: 'cupcake',
      },
      {
        name: 'donut',
      },
    ],
  });

  console.log('Create Content1 1/3...');
  await Promise.all(
    _.range(1, 6).map(async (n) => {
      return await prisma.content1.create({
        data: {
          name: `item ${n}`,
          categories: {
            create: {
              category: {
                connect: {
                  name: 'apple',
                },
              },
            },
          },
        },
      });
    }),
  );

  console.log('Create Content1 2/3...');
  await Promise.all(
    _.range(6, 11).map((n) => {
      prisma.content1.create({
        data: {
          name: `item ${n}`,
          categories: {
            create: {
              category: {
                connect: {
                  name: 'banana',
                },
              },
            },
          },
        },
      });
    }),
  );

  console.log('Create Content1 3/3...');
  await Promise.all(
    _.range(11, 16).map((n) => {
      prisma.content1.create({
        data: {
          name: `item ${n}`,
          categories: {
            create: {
              category: {
                connect: {
                  name: 'cupcake',
                },
              },
            },
          },
        },
      });
    }),
  );

  console.log('Create Category2...');
  await prisma.category2.createMany({
    data: [
      {
        name: 'apple',
      },
      {
        name: 'banana',
      },
      {
        name: 'cupcake',
      },
      {
        name: 'donut',
      },
    ],
  });

  console.log('Create Content2 1/2 ...');
  await prisma.content2.create({
    data: {
      name: `item 1`,
      categories: {
        connect: [
          {
            name: 'apple',
          },
          {
            name: 'banana',
          },
        ],
      },
    },
  });

  console.log('Create Content2 2/2 ...');
  await prisma.content2.create({
    data: {
      name: `item 2`,
      categories: {
        connect: [
          {
            name: 'cupcake',
          },
          {
            name: 'donut',
          },
        ],
      },
    },
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
