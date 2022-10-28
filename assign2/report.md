# myLPF
## 접근 방법
이중 for문을 돌면서 문제에서 주어진 공식에 값을 대입하여 H(u, v)를 구한다.

## 결과
### cutoff frequency 변경(order 고정)
#### 50
![50](https://user-images.githubusercontent.com/78265252/195963384-7204150e-757e-4249-ba97-a968b0ec649e.jpg)

#### 100
![100](https://user-images.githubusercontent.com/78265252/195963391-0b793a16-c18b-4c36-980a-34951cb328bd.jpg)

#### 200
![200](https://user-images.githubusercontent.com/78265252/195963392-cebcb07c-10ca-4735-92c6-14668afef0c3.jpg)

### order 변경(cutoff frequency 고정)
#### 1
![1](https://user-images.githubusercontent.com/78265252/195963593-497545ec-e1ca-43f8-8df9-e771bcf49527.jpg)

#### 5
![5](https://user-images.githubusercontent.com/78265252/195963594-90f54e14-f889-46b2-839e-3b05f6723372.jpg)

#### 10
![10](https://user-images.githubusercontent.com/78265252/195963595-b08cf611-ac35-401e-8a38-9eef67438bef.jpg)

## 고찰
cutoff frequency가 커질수록 blurring이 줄어드는 것을 볼 수 있다. 또한 order가 커질수록 Gaussian -> Ieal 방향으로 shift 되는데 blurring은 줄어드는 대신 ringing 효과가 증가하게 되는 것을 볼 수 있다.

# myHBF
## 접근 방법
myLPF에서 구한 방법으로 H 함수를 구하고 이후 이중 for문을 돌면서 F와 H를 곱하여 필터가 적용된 G 함수를 구한다.

## 결과
### cutoff frequency 변경(나머지 고정)
#### 50
![50](https://user-images.githubusercontent.com/78265252/195964026-44744d96-97e8-4056-8691-53c2903092fe.jpg)

#### 100
![100](https://user-images.githubusercontent.com/78265252/195964027-ed70eb02-28a3-4f1d-85bb-22efaa331dea.jpg)

#### 200
![200](https://user-images.githubusercontent.com/78265252/195964028-21f77229-65ef-40fa-a7b7-90e1e87f427d.jpg)

### order 변경(나머지 고정)
#### 1
![1](https://user-images.githubusercontent.com/78265252/195964081-9132c21f-d13c-4a69-beb9-437aba7446f0.jpg)

#### 5
![5](https://user-images.githubusercontent.com/78265252/195964083-0bd6fef8-119f-4319-9946-ac263c72eea9.jpg)

#### 10
![10](https://user-images.githubusercontent.com/78265252/195964084-191e9b6f-3eb3-4a2c-9d6d-709e05aef383.jpg)

### boosting weight 변경(나머지 고정)
#### 10
![10](https://user-images.githubusercontent.com/78265252/195963883-c1033a9e-0b94-425d-ad79-2d2f8c85c180.jpg)

#### 20
![20](https://user-images.githubusercontent.com/78265252/195963884-09e1469e-fccd-4a98-88ee-184437ace420.jpg)

#### 30
![30](https://user-images.githubusercontent.com/78265252/195963885-26e73c3b-0198-4615-8cd5-346886363cd4.jpg)

## 고찰
cutoff frequency가 커질수록 blurring이 줄어드는 것을 볼 수 있다. 또한 boosting weight를 높일수록 blurring의 정도가 줄어드는 것을 볼 수 있는데 noisy가 조금 생기는 것 같다.

# myNotch
## 접근 방법
행, 열을 기준으로 각각 최대 몇 개의 peak를 찾는다. 이후 행과 열 모두에 peak가 나타나는 좌표를 spot으로 저장하고 Butterworth notch reject filter 공식에 대입하여 H(u, v)를 구한다.

## 결과
![untitled](https://user-images.githubusercontent.com/78265252/195978493-58c9ec04-01c2-4000-80a3-7f9ee2934273.jpg)

## 고찰
noise가 조금 없어지는 것을 볼 수 있다.
