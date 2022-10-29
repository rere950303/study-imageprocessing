# myCDF
## 접근 방법
각 intensity의 분포를 나타내는 행렬을 선언하고 pixel의 개수를 카운팅 하여 행렬의 각 요소를 구한다. 확률을 다 구했다면 변수 하나를 선언하여 누적합을 구해나가면서 output을 구한다.
픽셀의 전체 개수를 구할 때 상수를 대입하기보다는 input으로 주어진 이미지의 차원을 이용하여 구한다. 이렇게 해야지만 `myCDF` 함수를 효율적으로 재활용할 수 있다.
## 결과
<img src="https://user-images.githubusercontent.com/78265252/193185215-f41a5570-e38a-4243-9303-bd80eb328c18.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193185211-4e343d59-a53c-4dc3-bebd-bdfb43e864f4.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193185210-eceb4240-d6c7-4fc9-aca8-1c1498e8836f.jpg" width="200" height="200">

## 결과 분석
- CDF는 확률의 누적합이므로 1로 수렴하는 것을 볼 수 있다.
- 과제에서 주어진 이미지의 경우 현재 특정 intensity에 픽셀이 집중되어 있는 것을 볼 수 있다. 즉 intensity의 contrast가 부족하여 이미지의 대비 효과가 적어 눈에 잘 띄지 않는 특징이 있다.

# myHE
## 접근 방법
input으로 주어진 이미지의 각 픽셀마다 intensity를 변환하다. 이전에 구한 CDF와 intensity의 범위를 이용하여 변환 이후의 intensity 값을 구한다.
skeleton에서는 `myHE` 함수의 input으로 이전에 구한 CDF를 넣어주지 않으므로 다시 한번 `myCDF` 함수를 호출하여 CDF를 구한다.

## 결과
<img src="https://user-images.githubusercontent.com/78265252/193185804-bcff6c2b-721b-43f5-91eb-644e10b81a7f.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193185802-598011b3-131a-4365-8da7-f754158b5600.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193185800-3773171a-aa11-4b0b-a6fa-453b79384a6c.jpg" width="200" height="200">

## 결과 분석
- historam이 이전보다 넓게 분포하는 것을 볼 수 있다. 완벽하지는 않지만 중앙 intensity에 집중되어 있던 픽셀이 양옆으로 퍼지게 되었다.
- CDF 또한 완벽하지는 않지만 일정하게 상승하는 모양으로 변한 것을 볼 수 있다.
- 이미지의 contrast가 증가하여 이전보다 이미지의 세세한 부분 등 특징이 더 눈에 잘 띄는 것을 볼 수 있다.

# myAHE
## 접근 방법
각 tile 별로 CDF를 저장하는 3차원 행렬을 선언한다. 이후 행과 열의 interval을 각각 계산하고 `myCDF` 함수를 이용하여 각 tile 별 CDF를 구한다.
input으로 주어진 이미지의 각 픽셀의 intensity를 변경해야 하는데 먼저 특정 픽셀에 가장 근접한 left & top tile의 좌표를 구한다.
이후 시계방향으로 좌표를 회전하면서 유효한 tile의 좌표를 행렬에 저장한다.
위와 같은 과정이 마무리되면 행렬에 저장된 tile의 개수를 기준으로 corner, boundary, center 여부를 판단하고 각 tile의 CDF를 이용하여 intensity 변환 값을 각각 구한다.
최종적으로 boundary라면 linear interpolation, center라면 bilinear interpolation를 진행한다.

## tile 개수 변화에 따른 결과
### 10 x 10
<img src="https://user-images.githubusercontent.com/78265252/193188043-70bb7e1a-0a6a-41c4-8b1d-3a8143c7fd6d.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188329-8d8212fa-2e72-4672-8440-ec500ee2d1dd.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188315-4b4e25ad-3dfe-4d17-8751-3c501b36db66.jpg" width="200" height="200">

### 20 x 20
<img src="https://user-images.githubusercontent.com/78265252/193188772-bd2e3a72-95cc-4361-b897-8e2ff5c1a563.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188785-f2fde2b1-6f38-4ef8-b305-0e591cd4b7f3.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188801-a8d09631-0ce6-451e-8684-91ca5897f0e9.jpg" width="200" height="200">

</br></br></br>

### 30 x 30
<img src="https://user-images.githubusercontent.com/78265252/193188772-bd2e3a72-95cc-4361-b897-8e2ff5c1a563.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188785-f2fde2b1-6f38-4ef8-b305-0e591cd4b7f3.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193188801-a8d09631-0ce6-451e-8684-91ca5897f0e9.jpg" width="200" height="200">

### 40 x 40
<img src="https://user-images.githubusercontent.com/78265252/193189226-ca7d5efd-e7e7-4672-8d17-b1fc5685087a.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189238-dc10f378-d451-49e5-948c-6098ac8cf145.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189246-55594866-db89-4e0c-ab89-524aa980742c.jpg" width="200" height="200">

### 50 x 50
<img src="https://user-images.githubusercontent.com/78265252/193189308-414103c2-c2f8-4904-a89a-e7fb0211bff0.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189317-9555ba04-0872-4259-9ab0-532f3f42cf65.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189321-6ba16fa6-37df-4e91-bc68-6552de9ff2cb.jpg" width="200" height="200">

### 60 x 60
<img src="https://user-images.githubusercontent.com/78265252/193189399-7b45bfc1-7fe6-4498-909b-30518db06e4b.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189404-0b8ac93c-e078-4da7-b5b7-3928300f5a7f.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189412-805cb372-1d6f-4855-9942-98d653e6f335.jpg" width="200" height="200">

### 70 x 70
<img src="https://user-images.githubusercontent.com/78265252/193189474-054fb5e2-eba9-487b-9f98-b6afe7135280.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189479-2811728e-9e08-44eb-ae8e-25930b2fd8f7.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189482-bf2a11f0-250c-4c13-8f89-19618f193008.jpg" width="200" height="200">

### 80 x 80
<img src="https://user-images.githubusercontent.com/78265252/193189566-b5f1ffcb-b23d-4ed8-baee-5c4fdf5383a0.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189570-b02e4c40-a77e-49a3-bda3-bacecee5dcd2.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189578-079cc547-e3a3-4ad9-80fe-417bcc20f25a.jpg" width="200" height="200">

### 90 x 90
<img src="https://user-images.githubusercontent.com/78265252/193189640-9d4ae559-c3aa-44f7-8c26-6b696e1ac245.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189647-f341a6b6-3db1-4c45-b59c-d028a1139bf3.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189659-7a9fe5c1-5c20-4677-b469-dca1086a509f.jpg" width="200" height="200">

### 100 x 100
<img src="https://user-images.githubusercontent.com/78265252/193189715-174e5280-e52f-41ad-ab9b-a0746aeaa29c.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189719-d2285966-13a4-4686-b7bf-c3ff076e8b3a.jpg" width="200" height="200">
<img src="https://user-images.githubusercontent.com/78265252/193189723-d311b5d4-3564-4f4c-9a26-eda76727c517.jpg" width="200" height="200">

## 결과 분석
- tile의 개수가 증가할수록 histogram이 더 평평해지는 것을 볼 수 있다.
- 특이한 점은 tile의 개수가 일정 범위를 넘어가게 되면 CDF의 마지막 부분에서 pulse처럼 급격히 증가하는 구간이 생긴다는 것이다. tile의 개수가 많아지면 각 tile에 매핑되는 CDF에서 특정 intensity의 확률이 매우 높아지므로 이와 같은 현상이 발생하는 것 같다.
- 위와 같은 이유로 tile 개수가 증가할수록 이미지에서 매우 밝게 존재하는 픽셀의 개수가 점점 증가하는 것을 볼 수 있다.

# 고찰
수업 시간에 배운 histogram equalization에 대해 직접 실습해 보면서 깊이 있는 이해를 할 수 있었다. 특히 `myAHE` 함수 구현에 애를 먹었는데 adaptive histogram equalization의 정확한 이해와 체계적인 구현으로 해결할 수 있었다.