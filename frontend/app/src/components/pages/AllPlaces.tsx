import { Center, Flex, Spinner, Wrap, WrapItem, useDisclosure, Box, Button, Image } from "@chakra-ui/react";
import { FC, memo, useState, useEffect, useCallback, createContext, Dispatch, SetStateAction } from "react";
import { useMessage } from "hooks/useMessage"

import { PlaceAll } from "lib/api/place";
import { PlaceCard } from "components/organisms/place/PlaceCard";
import { Place } from "types/api/place";
import { FilterDrawer } from "components/molecules/FilterDrawer";
import filter_icon from "img/511_s_f.png"
import { FilterAccordion } from "components/organisms/FilterAccordion";
import { SearchBox } from "components/molecules/SearchBox";
import { Genres } from "types/states/genre";
import { Countries } from "types/states/country";
import { Types } from "types/states/type";
import { GenreAll } from "lib/api/genre";
import { CountryAll } from "lib/api/country";
import { Country } from "types/api/country";
import { TypeAll } from "lib/api/type";
import { Type } from "types/api/type";
import { Genre } from "types/api/genre";

export const PlaceContext = createContext({} as {
  onCloseFilterDrawer: () => void;
  isOpenFilterDrawer: () => void;
  onClickClear: () => void;
  setPlaces: Dispatch<SetStateAction<Place[]>>;
  genres: Array<Genres>;
  setGenres: Dispatch<SetStateAction<Genres[]>>;
  countries: Array<Countries>;
  setCountries: Dispatch<SetStateAction<Countries[]>>;
  types: Array<Types>;
  setTypes: Dispatch<SetStateAction<Types[]>>;
  genre_categories: string[];
  country_states: string[];
  keyword: string;
  setKeyword: Dispatch<SetStateAction<string>>;
})

export const AllPlaces: FC = memo(() => {

  const [places, setPlaces] = useState<Array<Place>>([])
  const [genres, setGenres] = useState<Array<Genres>>([])
  const [countries, setCountries] = useState<Array<Countries>>([])
  const [types, setTypes] = useState<Array<Types>>([])
  const [loading, setLoading] = useState(false)
  const [keyword, setKeyword] = useState<string>("")
  const {showMessage} = useMessage()

  const {
    isOpen: isOpenFilterDrawer,
    onOpen: onOpenFilterDrawer,
    onClose: onCloseFilterDrawer
  } = useDisclosure()

  const getPlaces = async () => {
    setLoading(true)
    const res = await PlaceAll()
    console.log(res)

    if (res.status === 200) {
      setPlaces(res.data)
    }else {
      showMessage({title: "ユーザー取得に失敗しました", status: "error"})
    }
    setLoading(false)
  }

  const getGenres = async () => {
    setLoading(true)
    const res = await GenreAll()
    console.log(res)

    if (res.status === 200) {
      const genreRes = res.data
      const genreState = genreRes.map((genre: Genre) => {
        return { label: genre.name, category: genre.category, place_names: genre.places.map((place) => place.name), checked: false}
      })
      setGenres(genreState)
    }else {
      showMessage({title: "ユーザー取得に失敗しました", status: "error"})
    }
    setLoading(false)
  }

  const getCountries = async () => {
    setLoading(true)
    const res = await CountryAll()
    console.log(res)

    if (res.status === 200) {
      const countryRes = res.data
      const countryState = countryRes.map((country: Country) => {
        return { label: country.name, state: country.state.name, place_names: country.places.map((place) => place.name), checked: false}
      })
      setCountries(countryState)
    }else {
      showMessage({title: "ユーザー取得に失敗しました", status: "error"})
    }
    setLoading(false)
  }

  const getTypes = async () => {
    setLoading(true)
    const res = await TypeAll()
    console.log(res)

    if (res.status === 200) {
      const typeRes = res.data
      const typeState = typeRes.map((type: Type) => {
        return { label: type.name, place_names: type.places.map((place) => place.name), checked: false}
      })
      setTypes(typeState)
    }else {
      showMessage({title: "ユーザー取得に失敗しました", status: "error"})
    }
    setLoading(false)
  }

  useEffect(() => {getPlaces()}, [])
  useEffect(() => {getGenres()}, [])
  useEffect(() => {getCountries()}, [])
  useEffect(() => {getTypes()}, [])

  const genre_categories = [ "自然", "人工" ]
  const country_states = [ "アフリカ", "ヨーロッパ", "中東", "アジア", "オセアニア", "北米", "南米" ]

  const onClickClear = useCallback(() => {
    const newGenres = genres.map(genre => {
      genre.checked = false
      return genre
    })
    setGenres(newGenres)

    const newCountries = countries.map(country => {
      country.checked = false
      return country
    })
    setCountries(newCountries)

    const newTypes = types.map(type => {
      type.checked = false
      return type
    })
    setTypes(newTypes)

    setKeyword("")

    getPlaces()
  }, [])

  return (
    <>
      {loading ? (
        <Center h="90vh">
          <Spinner />
        </Center>
      ) :(
        <PlaceContext.Provider value={{onCloseFilterDrawer, isOpenFilterDrawer, onClickClear, setPlaces, genres, setGenres,
          countries, setCountries, types, setTypes, genre_categories, country_states, keyword, setKeyword}}>
          <Flex py={{base: 6, md: 10, lg: 12}} px={{base: 3, md: 6, lg: 10}} display={{ base: "block", md: "flex"}} bg="black">
            <FilterAccordion />
            <Box display={{ base: "block", md: "none"}} pb="3">
              <Button colorScheme='red' variant='outline' onClick={onOpenFilterDrawer}  bg="white" >
                <Image  boxSize="20px" src={filter_icon} color="red"
                        mr="2" />
                絞り込み
              </Button>
            </Box>
            <FilterDrawer />
            <Box w={{md: "75%", lg: "80%"}} align="center">
              <SearchBox />
              <Wrap >
                {places.map((place) => (
                  <WrapItem key={place.id}>
                    <PlaceCard imageUrl={place.imageUrl} name={place.name} countries={place.countries}/>
                  </WrapItem>
                ))}
              </Wrap>
            </Box>
          </Flex>
        </PlaceContext.Provider>
      )}
    </>
  )
})
