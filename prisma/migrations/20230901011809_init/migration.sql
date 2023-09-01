-- CreateTable
CREATE TABLE "Content1" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Content1_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category1" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Category1_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Content2" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Content2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category2" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Category2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContentsOnCategories" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "content1Id" INTEGER NOT NULL,
    "category1Id" INTEGER NOT NULL,

    CONSTRAINT "ContentsOnCategories_pkey" PRIMARY KEY ("content1Id","category1Id")
);

-- CreateTable
CREATE TABLE "_Category2ToContent2" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Content1_name_key" ON "Content1"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Category1_name_key" ON "Category1"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Content2_name_key" ON "Content2"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Category2_name_key" ON "Category2"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_Category2ToContent2_AB_unique" ON "_Category2ToContent2"("A", "B");

-- CreateIndex
CREATE INDEX "_Category2ToContent2_B_index" ON "_Category2ToContent2"("B");

-- AddForeignKey
ALTER TABLE "ContentsOnCategories" ADD CONSTRAINT "ContentsOnCategories_content1Id_fkey" FOREIGN KEY ("content1Id") REFERENCES "Content1"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContentsOnCategories" ADD CONSTRAINT "ContentsOnCategories_category1Id_fkey" FOREIGN KEY ("category1Id") REFERENCES "Category1"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Category2ToContent2" ADD CONSTRAINT "_Category2ToContent2_A_fkey" FOREIGN KEY ("A") REFERENCES "Category2"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Category2ToContent2" ADD CONSTRAINT "_Category2ToContent2_B_fkey" FOREIGN KEY ("B") REFERENCES "Content2"("id") ON DELETE CASCADE ON UPDATE CASCADE;
