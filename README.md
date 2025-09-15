# VK Cloud

Описание инфраструктуры на terraform

Создается кластер Kubernetes


(base) solar@coffee:~/work/ninja360/vk-cloud-terraform$ openstack flavor list
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+
| ID                                   | Name              |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+
| 00bbf595-aa67-437a-b566-92cbe8d00941 | STD2-16-32        | 32768 |    0 |         0 |    16 | True      |
| 03c66e24-b386-4ceb-91f8-36e898d7fa72 | STD3-1-2          |  2048 |    0 |         0 |     1 | True      |
| 04db9642-04fe-474b-89cb-c5a778be9ef3 | STD2-6-24         | 24576 |    0 |         0 |     6 | True      |
| 09dc1341-762d-48c4-9657-61320279c875 | STD2-8-20         | 20480 |    0 |         0 |     8 | True      |
| 09dc3eb9-fc46-44b1-8928-acd42f723747 | Standard-4-12     | 12288 |    0 |         0 |     4 | True      |
| 0c5d5d41-1317-4331-ab58-9c9e04da50d6 | STD2-4-12         | 12288 |    0 |         0 |     4 | True      |
| 12dc66d3-828c-4495-a5ca-ea1710c33174 | Advanced-12-24    | 24576 |    0 |         0 |    12 | True      |
| 17f80791-c0dd-4124-adaa-8c4a83fa0c51 | STD2-8-16         | 16384 |    0 |         0 |     8 | True      |
| 18966af1-7aaa-4047-9df2-bf29c92d34f2 | STD2-6-32         | 32768 |    0 |         0 |     6 | True      |
| 19ad4a49-5b3d-43bc-a61d-b4b8b44c9842 | STD3-16-64        | 65536 |    0 |         0 |    16 | True      |
| 19b38715-48cd-495b-9391-4c4e9d424518 | Basic-1-2-40      |  2048 |   40 |         0 |     1 | True      |
| 19dc16ec-6d6c-4a34-af1a-ff5cbb056bed | STD3-6-12         | 12288 |    0 |         0 |     6 | True      |
| 1b624937-3fef-4ad2-8658-a0a94da58ac0 | STD3-4-4          |  4096 |    0 |         0 |     4 | True      |
| 252b6409-2aa3-47e4-89e1-2870fe3e3e1a | STD2-12-48        | 49152 |    0 |         0 |    12 | True      |
| 25ae869c-be29-4840-8e12-99e046d2dbd4 | Basic-1-2-20      |  2048 |   20 |         0 |     1 | True      |
| 27acd0b9-4d89-4acc-853c-e3e416704ba0 | STD3-2-6          |  6144 |    0 |         0 |     2 | True      |
| 283fa444-8d59-4e83-b6f4-90613c52a5a4 | Advanced-8-16-100 | 16384 |  100 |         0 |     8 | True      |
| 2a95f323-59ba-4f62-990f-4c3e34bf922e | STD3-2-4          |  4096 |    0 |         0 |     2 | True      |
| 2c7c3f57-b5a4-4139-af7d-d5f05d70c703 | Standard-6-24     | 24576 |    0 |         0 |     6 | True      |
| 2d9866a9-e955-4986-b00a-340ca54b2cac | STD3-2-8          |  8192 |    0 |         0 |     2 | True      |
| 2df6e3ec-5939-4d28-a818-89558ff1b7ab | STD2-2-8          |  8192 |    0 |         0 |     2 | True      |
| 3553977b-e3db-4ced-af76-dc30fd1f9eae | STD3-4-8          |  8192 |    0 |         0 |     4 | True      |
| 366704e5-2315-4164-bb27-c353dcc2cbbb | STD2-4-4          |  4096 |    0 |         0 |     4 | True      |
| 3981b9fe-8b6d-4c09-b030-3ac788ae217a | STD3-4-12         | 12288 |    0 |         0 |     4 | True      |
| 39c18e7b-d5d3-4bb5-bdd2-df40e6773aa7 | STD2-12-12        | 12288 |    0 |         0 |    12 | True      |
| 39f697eb-393b-4b4a-93a6-321e4cfcf5be | STD3-12-8         |  8192 |    0 |         0 |    12 | True      |
| 3bb8d345-fbe9-4483-885a-912d3cd96855 | STD2-4-16         | 16384 |    0 |         0 |     4 | True      |
| 3be73bcf-72d8-4853-bb33-c8cbaa8a8480 | STD2-2-4          |  4096 |    0 |         0 |     2 | True      |
| 4320b6fa-1914-4e11-ba1f-35dca3494386 | STD3-2-2          |  2048 |    0 |         0 |     2 | True      |
| 44bc1bd6-c6fe-4ca7-a369-9f4102340c07 | STD2-8-24         | 24576 |    0 |         0 |     8 | True      |
| 467c1b72-a6a2-4375-9cca-078cdc5bfdde | STD2-2-2          |  2048 |    0 |         0 |     2 | True      |
| 4e115a9b-0ac2-440d-a120-95cf130d63c7 | Standard-2-2      |  2048 |    0 |         0 |     2 | True      |
| 4feeeef0-5ad9-4a55-a291-6b1773aa3af3 | STD2-1-4          |  4096 |    0 |         0 |     1 | True      |
| 50ca3de9-a461-42b5-991a-5257b068d9b1 | STD2-6-36         | 36864 |    0 |         0 |     6 | True      |
| 50d8db03-dc2a-4ee0-bbba-b8029eb9ccd5 | STD3-6-8          |  8192 |    0 |         0 |     6 | True      |
| 52f90145-a38e-438d-9c4b-3874b6355db3 | Advanced-8-8      |  8192 |    0 |         0 |     8 | True      |
| 54631d59-c149-46c8-9691-85c10dccf787 | STD2-12-32        | 32768 |    0 |         0 |    12 | True      |
| 56e2fec6-ce41-4832-b537-7cbe95757aac | STD2-1-2          |  2048 |    0 |         0 |     1 | True      |
| 59f7faf3-d817-4cb8-ae69-8b4b92565f94 | Advanced-16-64-50 | 65536 |   50 |         0 |    16 | True      |
| 5a7f78a6-9315-4e0d-ae42-c833ce5e518b | STD2-8-32         | 32768 |    0 |         0 |     8 | True      |
| 5fb1ab8f-fdab-4b43-a785-ef87b06ed2dd | Standard-6-6      |  6144 |    0 |         0 |     6 | True      |
| 6685fb8d-386f-45ee-9584-411ec3d8dd5f | STD3-16-16        | 16384 |    0 |         0 |    16 | True      |
| 670f9d36-d01b-4a4a-a8e5-c88cfb9ea0ec | Advanced-16-32-50 | 32768 |   50 |         0 |    16 | True      |
| 684e04db-13d6-4879-aff7-14cb98e7577a | Advanced-8-24     | 24576 |    0 |         0 |     8 | True      |
| 69cd369e-312a-4098-bdd9-112d092b7ad3 | Advanced-12-36    | 36864 |    0 |         0 |    12 | True      |
| 6d89f25a-a4b5-4b4d-b2fa-d08d701e5106 | Advanced-12-12    | 12288 |    0 |         0 |    12 | True      |
| 6ff0ca25-a90d-4f4b-ad71-a2cfb883e79f | STD3-12-24        | 24576 |    0 |         0 |    12 | True      |
| 72e08e66-77a8-457f-b86e-6dea452fd301 | STD3-6-18         | 18432 |    0 |         0 |     6 | True      |
| 738b4989-2105-45aa-acf5-ed243d59a968 | Standard-6-12     | 12288 |    0 |         0 |     6 | True      |
| 76fd2a82-4095-49b7-acc9-80ee90284ce9 | Advanced-8-32-50  | 32768 |   50 |         0 |     8 | True      |
| 77109506-bf0c-44a9-9e97-53360e9898bc | Standard-4-8-50   |  8192 |   50 |         0 |     4 | True      |
| 7e6f3416-f74a-40b5-86e8-82d14615f329 | Basic-1-4-50      |  4096 |   50 |         0 |     1 | True      |
| 7f04b02c-5260-4b5d-bccf-4151c5ade92d | Advanced-8-16-160 | 16384 |  160 |         0 |     8 | True      |
| 81229041-0a76-49e6-bfc1-cddddce573f2 | STD3-4-20         | 20480 |    0 |         0 |     4 | True      |
| 82e9b9d1-e9dd-4647-9bf6-4411b0b6365a | STD2-12-24        | 24576 |    0 |         0 |    12 | True      |
| 86858474-5653-4761-b490-70fc5d47936a | STD2-8-8          |  8192 |    0 |         0 |     8 | True      |
| 8a1d1408-aa72-4fa7-acd5-b906c6e41f4e | Advanced-16-48    | 49152 |    0 |         0 |    16 | True      |
| 8b64c09b-7141-41ad-a81e-9f5a8dbbd87e | Standard-2-6      |  6144 |    0 |         0 |     2 | True      |
| 8f44fbe4-b930-4e9b-9f5d-eaf7a24661b9 | STD3-12-36        | 36864 |    0 |         0 |    12 | True      |
| 908479b5-1138-46b6-b746-48bf6c24e548 | Standard-4-8-80   |  8192 |   80 |         0 |     4 | True      |
| 92d4c6d6-f6da-4db3-a75d-763157e66f87 | STD2-10-14        | 14336 |    0 |         0 |    10 | True      |
| 945f24ba-8b30-4bce-8159-2125861a7beb | STD3-16-32        | 32768 |    0 |         0 |    16 | True      |
| 94d277e1-08bd-45cd-824e-8ddaaa8325ef | STD3-1-1          |  1024 |    0 |         0 |     1 | True      |
| 97b695a6-2269-49e8-89a2-577fa789bb25 | STD2-6-12         | 12288 |    0 |         0 |     6 | True      |
| 9cae787c-25f8-4b77-bd91-9eab98ba498c | Standard-6-18     | 18432 |    0 |         0 |     6 | True      |
| 9cdbca68-5e15-4c54-979d-9952785ba33e | STD2-1-1          |  1024 |    0 |         0 |     1 | True      |
| a0ba9df3-437c-4689-81fd-447fb295e842 | STD3-18-24        | 24576 |    0 |         0 |    18 | True      |
| a24f1095-a8ec-44f1-97b5-b3d9c0a972a8 | STD3-12-12        | 12288 |    0 |         0 |    12 | True      |
| a26d0e84-cc4a-4c9f-8e11-be1e3e39435f | STD3-6-24         | 24576 |    0 |         0 |     6 | True      |
| a82ce79c-b45f-43de-bb73-3c793975cae0 | Advanced-16-16    | 16384 |    0 |         0 |    16 | True      |
| aee06bce-4ddf-4fa6-ba62-ec4210cc6bac | STD3-8-8          |  8192 |    0 |         0 |     8 | True      |
| b2c0fbeb-fafb-4394-adc5-3a9709e76249 | STD3-1-4          |  4096 |    0 |         0 |     1 | True      |
| b6760da7-d124-45c7-a0a7-64f40acae087 | STD3-4-16         | 16384 |    0 |         0 |     4 | True      |
| b7d20f15-82f1-4ed4-a12e-e60277fe955f | Standard-2-4-50   |  4096 |   50 |         0 |     2 | True      |
| b95087f9-3a2f-4414-b068-7a01f982f960 | STD2-4-8          |  8192 |    0 |         0 |     4 | True      |
| bd13f850-529f-4d02-8e8d-304229249fbb | STD2-16-48        | 49152 |    0 |         0 |    16 | True      |
| be207c95-a7e0-4b46-872e-c41983633c56 | STD2-4-6          |  6144 |    0 |         0 |     4 | True      |
| bf714720-78da-4271-ab7d-0cf5e2613f14 | Standard-2-8-50   |  8192 |   50 |         0 |     2 | True      |
| bfe65aec-9fd5-44c5-bd41-1f5ac8796125 | STD3-20-30        | 30720 |    0 |         0 |    20 | True      |
| c66723b0-3cfe-4965-ad1b-450126d2e326 | STD2-4-2          |  2048 |    0 |         0 |     4 | True      |
| c744bdda-ddd5-4a2c-bea1-5541f349a24b | STD3-16-48        | 49152 |    0 |         0 |    16 | True      |
| caa8a4cc-4b78-4edf-b380-c574e24c19e8 | STD2-2-6          |  6144 |    0 |         0 |     2 | True      |
| d1e52786-5e8e-4759-bea8-f03a87793cd0 | STD2-12-36        | 36864 |    0 |         0 |    12 | True      |
| d45cea98-b4df-42fe-8357-a1c66fb8fee2 | STD3-6-6          |  6144 |    0 |         0 |     6 | True      |
| d659fa16-c7fb-42cf-8a5e-9bcbe80a7538 | Standard-2-4-40   |  4096 |   40 |         0 |     2 | True      |
| d86d046d-12b2-4f3d-8a2f-94e0a7027cd7 | STD3-8-24         | 24576 |    0 |         0 |     8 | True      |
| d8caf0db-f76e-4c4d-8f91-7ef1ff560a6c | STD2-6-6          |  6144 |    0 |         0 |     6 | True      |
| d93251dd-e649-4e60-969d-2751d3995cc5 | STD3-8-16         | 16384 |    0 |         0 |     8 | True      |
| dbe2a8d3-c9fe-4f71-a539-88f7c996ee46 | STD2-6-18         | 18432 |    0 |         0 |     6 | True      |
| df3c499a-044f-41d2-8612-d303adc613cc | Basic-1-1-10      |  1024 |   10 |         0 |     1 | True      |
| e45015cc-4f72-4ab3-806e-47944f5e58e2 | STD3-12-48        | 49152 |    0 |         0 |    12 | True      |
| e72b2823-6f7e-433e-a18c-942ca2bb41aa | STD3-8-32         | 32768 |    0 |         0 |     8 | True      |
| ea26a8fe-5915-4bda-abdc-34b0be148e97 | Standard-4-16-50  | 16384 |   50 |         0 |     4 | True      |
| ed6c2c66-1f47-433c-b5d2-d171ebc327b6 | STD2-16-16        | 16384 |    0 |         0 |    16 | True      |
| f4b2f2c3-8844-4cd6-9695-6db04277d7d5 | STD2-16-64        | 65536 |    0 |         0 |    16 | True      |
| f9e5778d-903c-4ce9-b89c-9d3dd0347e9e | Standard-4-4      |  4096 |    0 |         0 |     4 | True      |
| fb1c24cc-e839-40d0-9ea1-7f40cdebe512 | STD3-24-16        | 16384 |    0 |         0 |    24 | True      |
| ff36d8ec-a8f8-4f37-a965-3f51fde411fc | Advanced-12-48    | 49152 |    0 |         0 |    12 | True      |
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+


export KUBECONFIG=/home/solar/.kube/ai-issue-genius-cluster_kubeconfig.yaml 

kubectl create secret docker-registry gitlab-registry \
  --docker-server=registry.gitlab.com \
  --docker-username=fedor.buzinov@gmail.com \
  --docker-password=glpat-HyAQkIS7s8fSxeWxki4BfG86MQp1OjF5eTNiCw.01.121lbky4d \
  --docker-email=fedor.buzinov@gmail.com \
  -n ai-issue-genius

kubectl apply -f redirect-ingress.yaml

kauthproxy -n kubernetes-dashboard https://kubernetes-dashboard.svc

kubectl config set-context --current --namespace=ai-issue-genius

kubectl describe pod postgres-54dfd9b479-t2cnd -n ai-issue-genius