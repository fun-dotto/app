# Map

キャンパスマップは `assets/map/imdf/` の IMDF を正本とし、MapLibre で描画する。

```mermaid
flowchart LR
  IMDF[assets/map/imdf] --> CampusMapDataSource
  CampusMapDataSource --> CampusMapRepositoryImpl
  CampusMapRepositoryImpl -->|CampusMap| FetchCampusMapUseCase
  FetchCampusMapUseCase --> CampusMapState
  CampusMapState --> MapScreen
  MapState[MapState (Room)] --> MapScreen
  MapScreen --> CampusMapView
```

| レイヤー     | ファイル                                                                 |
| ------------ | ------------------------------------------------------------------------ |
| Domain       | `domain/entity/campus_map.dart`, `campus_map_unit.dart`, `geo_*.dart` など |
| Data         | `data/campus_map_data_source.dart`, `data/campus_map_repository_impl.dart` |
| Application  | `application/fetch_campus_map_use_case.dart`                             |
| Presentation | `campus_map_state.dart`, `widget/campus_map_view.dart` など              |

- 区画 (`CampusMapUnit`) の種類ごとの配色は `campus_map_unit_style.dart` に定義する。
- 部屋の利用状況は `Room` (`MapState`) と `CampusMapUnit.roomId` で結び付ける。
